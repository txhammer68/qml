import QtQuick 2.9
import Qt.labs.folderlistmodel 2.15
import org.kde.plasma.core 2.1


Rectangle {
    id: root
    width: 1600
    height: 900
    color: "black"
    focus: true

    Keys.onEscapePressed :{
        Qt.quit();
    }

    //Slideshow options :
    property int slide_duration: 9000 //ms
    property int fade_duration: 500
    property int index: 0
    property variant rlist: []

    //Load 2 slides
    Loader {id:img1; transformOrigin: Item.TopLeft; sourceComponent: slide;}
    Loader {id:img2; transformOrigin: Item.TopLeft; sourceComponent: slide;}
    property variant current_img: img1

    //Input images files
    FolderListModel{
        id: img_files
        folder : "/home/matt/Pictures/wallpapers/vistas"
        nameFilters: [ "*.png", "*.jpg" ]
        showDirs: false
        showOnlyReadable: false
        caseSensitive : false
    }
    Timer {
        id:init
        interval:500
        running:true
        repeat:false
        onTriggered: {
            shuffleList();
            img1.item.asynchronous = false
            img1.item.visible = true;
            img1.item.load_next_slide();
            img2.item.load_next_slide();
            img1.item.asynchronous = true;
            mtimer.start();
        }
    }

Text {
    id:tx1
    text:""
    color:"white"
    font.pointSize:14
    anchors.bottom:parent.bottom
    anchors.right:parent.right
}


        function getNextUrl(){
            if(index <= rlist.length)
                shuffleList();
            //return img_files.get(rlist[index++], "fileUrl"); //filePath
             return rlist[index++]; //filePath
        }

        //Fisher-Yates shuffle algorithm.
        function shuffleArray(array) {
            for (var i = array.length - 1; i > 0; i--) {
                var j = Math.floor(Math.random() * (i + 1));
                var temp = array[i];
                array[i] = array[j];
                array[j] = temp;
            }
            return array;
        }

        function shuffleList()
        {
            console.log("Shuffle...");
            var list = [];
            for(var i=0; i<img_files.count; i++) {
             rlist[i]=img_files.get(i, "fileURL")
            }
            list=shuffleArray(rlist);
            rlist = list;
            index = 0;
        }
    //Main timer
    Timer{
        id:mtimer
        interval: slide_duration-fade_duration
        repeat: true
        triggeredOnStart : true

        onTriggered: {
            current_img.item.fadein();
            current_img = (current_img == img1 ? img2 : img1); //Swap img
            current_img.item.fadeout();
        }
    }

    //Slide component
    Component {
        id: slide

        Image {
            id: img
            asynchronous : true
            cache: false
            //fillMode: Image.PreserveAspectFit
            anchors.fill:root
            //visible: true
            opacity: 0
            width: root.width
            height: root.height

            //Max painted size (RPI limitations)
            //sourceSize.width: 1920
           // sourceSize.height: 1080

            property real from_scale: 1
            property real to_scale: 1

            property real from_x: 0
            property real to_x: 0

            property real from_y: 0
            property real to_y: 0

            function randRange(a, b){return Math.random()*Math.abs(a-b) + Math.min(a,b);}
            function randChoice(n){return Math.round(Math.random()*(n-1));}
            function randDirection(){return (Math.random() >= 0.5) ? 1 : -1;}

            function fadein(){
                //Check image loading...
                if(status != Image.Ready){
                    console.log("LOAD ERROR", source);
                    return;
                }

                //Fit in view
                var img_ratio = paintedWidth/paintedHeight;
                var scale = (height == paintedHeight) ? width/paintedWidth : height/paintedHeight;

                //Find random directions
                if(img_ratio < 1){ //Rotated
                    from_scale = scale*0.8;//Un-zoom on 16/9 viewer...
                    to_scale = from_scale;
                    from_y = 0;
                    to_y = 0;
                    from_x = randDirection()*(paintedHeight*from_scale-height)/2;
                    to_x = 0;
                }
                else if(img_ratio > 2){ //Panorama
                    from_scale = scale;
                    to_scale = from_scale;
                    from_y = randDirection()*(paintedWidth*from_scale-width)/2;
                    to_y = -from_y;
                    from_x = 0;
                    to_x = 0;
                }
                else {  //Normal
                    var type = randChoice(3);
                    switch(type)
                    {
                    case 0: //Zoom in
                        from_scale = scale;
                        to_scale = scale*1.4;
                        from_y = 0;
                        to_y = 0;
                        from_x = 0;
                        to_x = 0;
                        break;
                    case 1: //Zoom out
                        from_scale = scale*1.4;
                        to_scale = scale;
                        from_y = 0;
                        to_y = 0;
                        from_x = 0;
                        to_x = 0;
                        break;
                    default: //Fixed zoom
                        from_scale = scale*1.2;
                        to_scale = from_scale;
                      break;
                    }
                    //Random x,y
                    var from_max_y = (paintedWidth*from_scale-width)/2;
                    var to_max_y = (paintedWidth*to_scale-width)/2;
                    from_y = randRange(-from_max_y, from_max_y);
                    to_y = randRange(-to_max_y, to_max_y);

                    var from_max_x = (paintedHeight*from_scale-height)/2;
                    var to_max_x = (paintedHeight*to_scale-height)/2;
                    from_x = randRange(-from_max_x, from_max_x);
                    to_x = randRange(-to_max_x, to_max_x);
                }

                visible = true;
                afadein.start();
                tx1.text=img_files.get(img_files.indexOf(source),"fileBaseName")
                //tx1.text=img_files.get(rlist[index], "fileUrl")
                //tx1.text=source+"\n"+img_files.get(img_files.indexOf(rlist[1]),"fileUrl")
            }

            function fadeout(){
                afadeout.start();
            }

            function load_next_slide(){
                visible = false;
                source = getNextUrl();
                //console.log(source);
            }

            ParallelAnimation{
                id: afadein
                NumberAnimation {target: img; property: "opacity"; from: 0; to: 1; duration: fade_duration; easing.type: Easing.InOutQuad;}
                NumberAnimation {target: img; property: "y"; from: from_x; to: to_x; duration: slide_duration; }
                NumberAnimation {target: img; property: "x"; from: from_y; to: to_y; duration: slide_duration; }
                NumberAnimation {target: img; property: "scale"; from: from_scale; to: to_scale; duration: slide_duration; }
            }

            SequentialAnimation {
                 id: afadeout;
                 NumberAnimation{ target: img; property: "opacity"; from: 1; to: 0; duration: fade_duration; easing.type: Easing.InOutQuad;}
                 ScriptAction { script: img.load_next_slide(); }
             }
        }
    }
}
