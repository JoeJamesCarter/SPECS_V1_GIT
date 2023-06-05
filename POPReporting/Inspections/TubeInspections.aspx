<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TubeInspections.aspx.vb" Inherits="Inspections_TubeInspections" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tube Inspections</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js" type="text/javascript"></script>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        #stations {
            width: 213px;
            float: left;
            margin-right: 10px;
            margin-bottom: 13px;
            height: 140px;
            margin-top: 10px;
            border-style: solid;
            border-width: 1px;
            padding-left: 10px;
            margin-right:300px;
        }

        #buildinst {
            width: 208px;
            float: left;
            margin-right: 10px;           
            height: 110px;           
            border-style: solid;
            border-width: 1px;
            padding-left: 10px;
        }

        #drawing {
            width: 800px;
            margin-top: 20px;
            float: left;
            height: 252px;
        }

        #areas {
            width: 1136px;
            float: left;
        }
       
        .dents {
            background-color: blue;
            color: white;
            text-align: center;
            height: 50px;
            width: 90px;
            font-family: Calibri;
            font-size: 13px;
        }

        .cartdents {
            background-color: darkgreen;
            color: white;
            text-align: center;
            text-align: center;
            height: 50px;
            width: 90px;
            font-family: Calibri;
            font-size: 13px;
        }

        .scratches {
            background-color: orange;
            color: white;
            text-align: center;
            text-align: center;
            height: 50px;
            width: 90px;
            font-family: Calibri;
            font-size: 13px;
        }

        .splatter {
            background-color: darkorchid;
            color: white;
            text-align: center;
            text-align: center;
            height: 50px;
            width: 90px;
            font-family: Calibri;
            font-size: 13px;
        }

        .dust {
            background-color: darkkhaki;
            color: white;
            text-align: center;
            text-align: center;
            height: 50px;
            width: 90px;
            font-family: Calibri;
            font-size: 13px;
        }

        .burns {
            background-color: lawngreen;
            color: white;
            text-align: center;
            text-align: center;
            height: 50px;
            width: 90px;
            font-family: Calibri;
            font-size: 13px;
        }

        .marks {
            background-color: lightskyblue;
            color: white;
            text-align: center;
            text-align: center;
            height: 50px;
            width: 110px;
            font-family: Calibri;
            font-size: 13px;
        }

        .incompletewelds {
            background-color: red;
            color: white;
            text-align: center;
            text-align: center;
            height: 50px;
            width: 120px;
            font-family: Calibri;
            font-size: 13px;
        }

        .fitandfinish {
            background-color: darkblue;
            color: white;
            text-align: center;
            text-align: center;
            height: 50px;
            width: 110px;
            font-family: Calibri;
            font-size: 13px;
        }

        #content {
            width: 1500px;
            height: 746px;
        }

        #header {
            float: left;
            width: 55%;
        }

        #header2 {
            float: left;
            width: 55%;
        }

        #drawingbuttons {
            float: left;
            width: 25%;
            height: 46px;
        }

        #colorbuttons {
            width: 100%;
            text-align: center;
        }

        .auto-style1 {
        }

        .auto-style2 {
        }

        .selectors {
            float: left;
            font-family: Calibri;
        }

        .auto-style3 {}

        </style>
    <script>

        // Variables for referencing the canvas and 2dcanvas context
        var canvas, ctx;

        // Variables to keep track of the mouse position and left-button status 
        var mouseX, mouseY, mouseDown = 0;

        // Variables to keep track of the touch position
        var touchX, touchY;

        // Keep track of the old/last position when drawing a line
        // We set it to -1 at the start to indicate that we don't have a good value for it yet
        var lastX, lastY = -1;

        // Draws a line between the specified position on the supplied canvas name
        // Parameters are: A canvas context, the x position, the y position, the size of the dot
        function drawLine(ctx, x, y, size) {

            // If lastX is not set, set lastX and lastY to the current position 
            if (lastX == -1) {
                lastX = x;
                lastY = y;
            }

            // Let's use black by setting RGB values to 0, and 255 alpha (completely opaque)
            r = 0; g = 0; b = 0; a = 255;

            // Select a fill style
            ctx.strokeStyle = $('#selColor').val();
            ctx.lineWidth = 4 //$('#selWidth').val();

            // Set the line "cap" style to round, so lines at different angles can join into each other
            ctx.lineCap = "round";
            //ctx.lineJoin = "round";


            // Draw a filled line
            ctx.beginPath();

            // First, move to the old (previous) position
            ctx.moveTo(lastX, lastY);

            // Now draw a line to the current touch/pointer position
            ctx.lineTo(x, y);


            // Set the line thickness and draw the line
            ctx.lineWidth = size;
            ctx.stroke();
            cPush();
            ctx.closePath();

            // Update the last position to reference the current position
            lastX = x;
            lastY = y;
        }

        // Clear the canvas context using the canvas width and height
        function clearCanvas(canvas, ctx) {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        }

        // Keep track of the mouse button being pressed and draw a dot at current location
        function sketchpad_mouseDown() {
            mouseDown = 1;
            drawLine(ctx, mouseX, mouseY, 4);
        }

        // Keep track of the mouse button being released
        function sketchpad_mouseUp() {
            mouseDown = 0;

            // Reset lastX and lastY to -1 to indicate that they are now invalid, since we have lifted the "pen"
            lastX = -1;
            lastY = -1;
        }

        // Keep track of the mouse position and draw a dot if mouse button is currently pressed
        function sketchpad_mouseMove(e) {
            // Update the mouse co-ordinates when moved
            getMousePos(e);

            // Draw a dot if the mouse button is currently being pressed
            if (mouseDown == 1) {
                drawLine(ctx, mouseX, mouseY, 4);
            }
        }

        // Get the current mouse position relative to the top-left of the canvas
        function getMousePos(e) {
            if (!e)
                var e = event;

            if (e.offsetX) {
                mouseX = e.offsetX;
                mouseY = e.offsetY;
            }
            else if (e.layerX) {
                mouseX = e.layerX;
                mouseY = e.layerY;
            }
        }

        // Draw something when a touch start is detected
        function sketchpad_touchStart() {
            // Update the touch co-ordinates
            getTouchPos();

            drawLine(ctx, touchX, touchY, 4);

            // Prevents an additional mousedown event being triggered
            event.preventDefault();
        }

        function sketchpad_touchEnd() {
            // Reset lastX and lastY to -1 to indicate that they are now invalid, since we have lifted the "pen"
            lastX = -1;
            lastY = -1;
        }

        // Draw something and prevent the default scrolling when touch movement is detected
        function sketchpad_touchMove(e) {
            // Update the touch co-ordinates
            getTouchPos(e);

            // During a touchmove event, unlike a mousemove event, we don't need to check if the touch is engaged, since there will always be contact with the screen by definition.
            drawLine(ctx, touchX, touchY, 4);

            // Prevent a scrolling action as a result of this touchmove triggering.
            event.preventDefault();
        }

        // Get the touch position relative to the top-left of the canvas
        // When we get the raw values of pageX and pageY below, they take into account the scrolling on the page
        // but not the position relative to our target div. We'll adjust them using "target.offsetLeft" and
        // "target.offsetTop" to get the correct values in relation to the top left of the canvas.
        function getTouchPos(e) {
            if (!e)
                var e = event;

            if (e.touches) {
                if (e.touches.length == 1) { // Only deal with one finger
                    var touch = e.touches[0]; // Get the information for finger #1
                    touchX = touch.pageX - touch.target.offsetLeft;
                    touchY = touch.pageY - touch.target.offsetTop;
                }
            }
        }


        // Set-up the canvas and add our event handlers after the page has loaded
        function init() {
            // Get the specific canvas element from the HTML document
            canvas = document.getElementById('myCanvas');

            var background = new Image();
            background.src = "../Images/tubeinspection.png";

            // Make sure the image is loaded first otherwise nothing will draw.
            background.onload = function () {
                ctx.drawImage(background, 0, 0);
                cPush();
            }
            // If the browser supports the canvas tag, get the 2d drawing context for this canvas
            if (canvas.getContext)
                ctx = canvas.getContext('2d');

            // Check that we have a valid context to draw on/with before adding event handlers
            if (ctx) {
                // React to mouse events on the canvas, and mouseup on the entire document
                canvas.addEventListener('mousedown', sketchpad_mouseDown, false);
                canvas.addEventListener('mousemove', sketchpad_mouseMove, false);
                window.addEventListener('mouseup', sketchpad_mouseUp, false);

                // React to touch events on the canvas
                canvas.addEventListener('touchstart', sketchpad_touchStart, false);
                canvas.addEventListener('touchend', sketchpad_touchEnd, false);
                canvas.addEventListener('touchmove', sketchpad_touchMove, false);
            }
            initTextboxes();
            CreateHotSpots();
        }


        var cPushArray = new Array();
        var cStep = -1;
        var ctx;
        // ctx = document.getElementById('myCanvas').getContext("2d");

        function cPush() {
            cStep++;
            if (cStep < cPushArray.length) { cPushArray.length = cStep; }
            cPushArray.push(document.getElementById('myCanvas').toDataURL());
        }
        function cUndo() {
            if (cStep > 0) {
                cStep--;
                var canvasPic = new Image();
                canvasPic.src = cPushArray[cStep];
                canvasPic.onload = function () { ctx.drawImage(canvasPic, 0, 0); }
            }
        }
        function cRedo() {
            if (cStep < cPushArray.length - 1) {
                cStep++;
                var canvasPic = new Image();
                canvasPic.src = cPushArray[cStep];
                canvasPic.onload = function () { ctx.drawImage(canvasPic, 0, 0); }
            }
        }

        function dents() {
            document.getElementById("selColor").value = "blue"
        }

        function cartdents() {
            document.getElementById("selColor").value = "green"
        }

        function scratches() {
            document.getElementById("selColor").value = "orange"
        }

        function splatter() {
            document.getElementById("selColor").value = "darkorchid"
        }

        function dust() {
            document.getElementById("selColor").value = "darkkhaki"
        }

        function burns() {
            document.getElementById("selColor").value = "lawngreen"
        }

        function marks() {
            document.getElementById("selColor").value = "skyblue"
        }

        function incompletewelds() {
            document.getElementById("selColor").value = "red"
        }

        function fitandfinish() {
            document.getElementById("selColor").value = "darkblue"
        }



        function initTextboxes() {
            document.getElementById("tbDentsFront").value = 0
            document.getElementById("tbDentsMid").value = 0
            document.getElementById("tbDentsRear").value = 0
            document.getElementById("tbDentsEndCap").value = 0
            document.getElementById("tbDentsNoseCone").value = 0

            document.getElementById("tbCartDentsFront").value = 0
            document.getElementById("tbCartDentsMid").value = 0
            document.getElementById("tbCartDentsRear").value = 0
            document.getElementById("tbCartDentsEndCap").value = 0
            document.getElementById("tbCartDentsNoseCone").value = 0

            document.getElementById("tbScratchesFront").value = 0
            document.getElementById("tbScratchesMid").value = 0
            document.getElementById("tbScratchesRear").value = 0
            document.getElementById("tbScratchesEndCap").value = 0
            document.getElementById("tbScratchesNoseCone").value = 0

            document.getElementById("tbSplatterFront").value = 0
            document.getElementById("tbSplatterMid").value = 0
            document.getElementById("tbSplatterRear").value = 0
            document.getElementById("tbSplatterEndCap").value = 0
            document.getElementById("tbSplatterNoseCone").value = 0


            document.getElementById("tbDustFront").value = 0
            document.getElementById("tbDustMid").value = 0
            document.getElementById("tbDustRear").value = 0
            document.getElementById("tbDustEndCap").value = 0
            document.getElementById("tbDustNoseCone").value = 0


            document.getElementById("tbBurnsFront").value = 0
            document.getElementById("tbBurnsMid").value = 0
            document.getElementById("tbBurnsRear").value = 0
            document.getElementById("tbBurnsEndCap").value = 0
            document.getElementById("tbBurnsNoseCone").value = 0


            document.getElementById("tbMarkerFront").value = 0
            document.getElementById("tbMarkerMid").value = 0
            document.getElementById("tbMarkerRear").value = 0
            document.getElementById("tbMarkerEndCap").value = 0
            document.getElementById("tbMarkerNoseCone").value = 0


            document.getElementById("tbIncompleteFront").value = 0
            document.getElementById("tbIncompleteMid").value = 0
            document.getElementById("tbIncompleteRear").value = 0
            document.getElementById("tbIncompleteEndCap").value = 0
            document.getElementById("tbIncompleteNoseCone").value = 0


            document.getElementById("tbFitFinishFront").value = 0
            document.getElementById("tbFitFinishMid").value = 0
            document.getElementById("tbFitFinishRear").value = 0
            document.getElementById("tbFitFinishEndCap").value = 0
            document.getElementById("tbFitFinishNoseCone").value = 0

        }

        //hotspots


        function CreateHotSpots() {

            //ctx.globalCompositeOperation = 'destination-over'; //make hotspots visible by uncommenting this line.

            var Rectangle = function (x, y, width, height) {
                this.x = x;
                this.y = y;
                this.width = width;
                this.height = height;
            }

            Rectangle.prototype.isHitBy = function (x, y, width, height) {
                return (x >= this.x && x <= this.x + this.width && y >= this.y && y <= this.y + this.height);
            }

            var Circle = function (x, y, radius) {
                this.x = x;
                this.y = y;
                this.radius = radius;
            }

            // Check if an x,y coordinate is inside the circle
            Circle.prototype.isHitBy = function (x, y) {

                // Get distance of passed x,y from circle midpoint
                var distance = Math.sqrt(Math.pow(x - this.x, 2) + Math.pow(y - this.y, 2));

                // If distance is less than radius, point is in circle
                return (distance <= this.radius);
            }

            //create shapes and draw them

            var front = new Rectangle(158, 20, 200, 65);
            var front2 = new Rectangle(465, 150, 200, 65)

            var rear = new Rectangle(55, 150, 200, 65);
            var rear2 = new Rectangle(565, 20, 200, 65)

            var mid = new Rectangle(360, 20, 204, 65);
            var mid2 = new Rectangle(255, 150, 208, 65)

            var nosecone = new Rectangle(663, 150, 125, 65)
            var nosecone2 = new Rectangle(35, 15, 120, 55)

            var cartdents = new Rectangle(580, 70, 100, 20)
            var cartdents2 = new Rectangle(555, 200, 100, 20)

            var cartdents3 = new Rectangle(160, 70, 100, 20)
            var cartdents4 = new Rectangle(155, 200, 100, 20)

            var endcap = new Circle(42, 110, 35);

            ctx.strokeRect(front.x, front.y, front.width, front.height); //top
            ctx.strokeRect(front2.x, front2.y, front2.width, front2.height);

            ctx.strokeRect(rear.x, rear.y, rear.width, rear.height);
            ctx.strokeRect(rear2.x, rear2.y, rear2.width, rear2.height); //top

            ctx.strokeRect(nosecone.x, nosecone.y, nosecone.width, nosecone.height);
            ctx.strokeRect(nosecone2.x, nosecone2.y, nosecone2.width, nosecone2.height);

            ctx.strokeRect(mid.x, mid.y, mid.width, mid.height);
            ctx.strokeRect(mid2.x, mid2.y, mid2.width, mid2.height);

            ctx.strokeRect(cartdents.x, cartdents.y, cartdents.width, cartdents.height);
            ctx.strokeRect(cartdents2.x, cartdents2.y, cartdents2.width, cartdents2.height);
            ctx.strokeRect(cartdents3.x, cartdents3.y, cartdents3.width, cartdents3.height);
            ctx.strokeRect(cartdents4.x, cartdents4.y, cartdents4.width, cartdents4.height);

            ctx.beginPath();
            ctx.arc(endcap.x, endcap.y, endcap.radius, 0, Math.PI * 2);
            ctx.stroke();

            canvas.addEventListener('click', function (e) {
                var canvasBounds = canvas.getBoundingClientRect();

                var clickX = e.pageX - canvasBounds.left;
                var clickY = e.pageY - canvasBounds.top;

                if (front.isHitBy(clickX, clickY)) {
                    console.log('Front');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsFront").value = parseInt(document.getElementById("tbDentsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsFront").value = parseInt(document.getElementById("tbCartDentsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesFront").value = parseInt(document.getElementById("tbScratchesFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterFront").value = parseInt(document.getElementById("tbSplatterFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustFront").value = parseInt(document.getElementById("tbDustFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsFront").value = parseInt(document.getElementById("tbBurnsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerFront").value = parseInt(document.getElementById("tbMarkerFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteFront").value = parseInt(document.getElementById("tbIncompleteFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishFront").value = parseInt(document.getElementById("tbFitFinishFront").value) + 1;
                    }
                }

                if (front2.isHitBy(clickX, clickY)) {
                    console.log('Front');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsFront").value = parseInt(document.getElementById("tbDentsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsFront").value = parseInt(document.getElementById("tbCartDentsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesFront").value = parseInt(document.getElementById("tbScratchesFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterFront").value = parseInt(document.getElementById("tbSplatterFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustFront").value = parseInt(document.getElementById("tbDustFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsFront").value = parseInt(document.getElementById("tbBurnsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerFront").value = parseInt(document.getElementById("tbMarkerFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteFront").value = parseInt(document.getElementById("tbIncompleteFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishFront").value = parseInt(document.getElementById("tbFitFinishFront").value) + 1;
                    }
                }

                if (mid.isHitBy(clickX, clickY)) {
                    console.log('Mid');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsMid").value = parseInt(document.getElementById("tbDentsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsMid").value = parseInt(document.getElementById("tbCartDentsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesMid").value = parseInt(document.getElementById("tbScratchesMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterMid").value = parseInt(document.getElementById("tbSplatterMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustMid").value = parseInt(document.getElementById("tbDustMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsMid").value = parseInt(document.getElementById("tbBurnsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerMid").value = parseInt(document.getElementById("tbMarkerMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteMid").value = parseInt(document.getElementById("tbIncompleteMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishMid").value = parseInt(document.getElementById("tbFitFinishMid").value) + 1;
                    }
                }

                if (mid2.isHitBy(clickX, clickY)) {
                    console.log('Mid');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsMid").value = parseInt(document.getElementById("tbDentsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsMid").value = parseInt(document.getElementById("tbCartDentsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesMid").value = parseInt(document.getElementById("tbScratchesMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterMid").value = parseInt(document.getElementById("tbSplatterMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustMid").value = parseInt(document.getElementById("tbDustMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsMid").value = parseInt(document.getElementById("tbBurnsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerMid").value = parseInt(document.getElementById("tbMarkerMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteMid").value = parseInt(document.getElementById("tbIncompleteMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishMid").value = parseInt(document.getElementById("tbFitFinishMid").value) + 1;
                    }
                }

                if (rear.isHitBy(clickX, clickY)) {
                    console.log('Rear');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsRear").value = parseInt(document.getElementById("tbDentsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsRear").value = parseInt(document.getElementById("tbCartDentsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesRear").value = parseInt(document.getElementById("tbScratchesRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterRear").value = parseInt(document.getElementById("tbSplatterRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustRear").value = parseInt(document.getElementById("tbDustRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsRear").value = parseInt(document.getElementById("tbBurnsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerRear").value = parseInt(document.getElementById("tbMarkerRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteRear").value = parseInt(document.getElementById("tbIncompleteRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishRear").value = parseInt(document.getElementById("tbFitFinishRear").value) + 1;
                    }
                }

                if (rear2.isHitBy(clickX, clickY)) {
                    console.log('Rear');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsRear").value = parseInt(document.getElementById("tbDentsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsRear").value = parseInt(document.getElementById("tbCartDentsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesRear").value = parseInt(document.getElementById("tbScratchesRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterRear").value = parseInt(document.getElementById("tbSplatterRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustRear").value = parseInt(document.getElementById("tbDustRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsRear").value = parseInt(document.getElementById("tbBurnsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerRear").value = parseInt(document.getElementById("tbMarkerRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteRear").value = parseInt(document.getElementById("tbIncompleteRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishRear").value = parseInt(document.getElementById("tbFitFinishRear").value) + 1;
                    }
                }

                if (endcap.isHitBy(clickX, clickY)) {
                    console.log('EndCap');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsEndCap").value = parseInt(document.getElementById("tbDentsEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsEndCap").value = parseInt(document.getElementById("tbCartDentsEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesEndCap").value = parseInt(document.getElementById("tbScratchesEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterEndCap").value = parseInt(document.getElementById("tbSplatterEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustEndCap").value = parseInt(document.getElementById("tbDustEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsEndCap").value = parseInt(document.getElementById("tbBurnsEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerEndCap").value = parseInt(document.getElementById("tbMarkerEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteEndCap").value = parseInt(document.getElementById("tbIncompleteEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishEndCap").value = parseInt(document.getElementById("tbFitFinishEndCap").value) + 1;
                    }
                }

                if (nosecone.isHitBy(clickX, clickY)) {
                    console.log('Nose Cone');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsNoseCone").value = parseInt(document.getElementById("tbDentsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsNoseCone").value = parseInt(document.getElementById("tbCartDentsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesNoseCone").value = parseInt(document.getElementById("tbScratchesNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterNoseCone").value = parseInt(document.getElementById("tbSplatterNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustNoseCone").value = parseInt(document.getElementById("tbDustNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsNoseCone").value = parseInt(document.getElementById("tbBurnsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerNoseCone").value = parseInt(document.getElementById("tbMarkerNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteNoseCone").value = parseInt(document.getElementById("tbIncompleteNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishNoseCone").value = parseInt(document.getElementById("tbFitFinishNoseCone").value) + 1;
                    }
                }

                if (nosecone2.isHitBy(clickX, clickY)) {
                    console.log('Nose Cone');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsNoseCone").value = parseInt(document.getElementById("tbDentsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsNoseCone").value = parseInt(document.getElementById("tbCartDentsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesNoseCone").value = parseInt(document.getElementById("tbScratchesNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterNoseCone").value = parseInt(document.getElementById("tbSplatterNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustNoseCone").value = parseInt(document.getElementById("tbDustNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsNoseCone").value = parseInt(document.getElementById("tbBurnsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerNoseCone").value = parseInt(document.getElementById("tbMarkerNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteNoseCone").value = parseInt(document.getElementById("tbIncompleteNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishNoseCone").value = parseInt(document.getElementById("tbFitFinishNoseCone").value) + 1;
                    }
                }



            });

            // Set up touch events for mobile, etc
            canvas.addEventListener("touchstart", function (e) {
                mousePos = getTouchPos(canvas, e);
                var touch = e.touches[0];
                var mouseEvent = new MouseEvent("mousedown", {
                    clientX: touch.clientX,
                    clientY: touch.clientY
                });
                canvas.dispatchEvent(mouseEvent);

                if (front.isHitBy(touchX, touchY)) {
                    console.log('Front');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsFront").value = parseInt(document.getElementById("tbDentsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsFront").value = parseInt(document.getElementById("tbCartDentsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesFront").value = parseInt(document.getElementById("tbScratchesFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterFront").value = parseInt(document.getElementById("tbSplatterFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustFront").value = parseInt(document.getElementById("tbDustFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsFront").value = parseInt(document.getElementById("tbBurnsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerFront").value = parseInt(document.getElementById("tbMarkerFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteFront").value = parseInt(document.getElementById("tbIncompleteFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishFront").value = parseInt(document.getElementById("tbFitFinishFront").value) + 1;
                    }
                }

                if (front2.isHitBy(touchX, touchY)) {
                    console.log('Front');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsFront").value = parseInt(document.getElementById("tbDentsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsFront").value = parseInt(document.getElementById("tbCartDentsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesFront").value = parseInt(document.getElementById("tbScratchesFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterFront").value = parseInt(document.getElementById("tbSplatterFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustFront").value = parseInt(document.getElementById("tbDustFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsFront").value = parseInt(document.getElementById("tbBurnsFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerFront").value = parseInt(document.getElementById("tbMarkerFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteFront").value = parseInt(document.getElementById("tbIncompleteFront").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishFront").value = parseInt(document.getElementById("tbFitFinishFront").value) + 1;
                    }
                }

                if (mid.isHitBy(touchX, touchY)) {
                    console.log('Mid');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsMid").value = parseInt(document.getElementById("tbDentsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsMid").value = parseInt(document.getElementById("tbCartDentsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesMid").value = parseInt(document.getElementById("tbScratchesMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterMid").value = parseInt(document.getElementById("tbSplatterMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustMid").value = parseInt(document.getElementById("tbDustMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsMid").value = parseInt(document.getElementById("tbBurnsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerMid").value = parseInt(document.getElementById("tbMarkerMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteMid").value = parseInt(document.getElementById("tbIncompleteMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishMid").value = parseInt(document.getElementById("tbFitFinishMid").value) + 1;
                    }
                }

                if (mid2.isHitBy(touchX, touchY)) {
                    console.log('Mid');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsMid").value = parseInt(document.getElementById("tbDentsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsMid").value = parseInt(document.getElementById("tbCartDentsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesMid").value = parseInt(document.getElementById("tbScratchesMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterMid").value = parseInt(document.getElementById("tbSplatterMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustMid").value = parseInt(document.getElementById("tbDustMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsMid").value = parseInt(document.getElementById("tbBurnsMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerMid").value = parseInt(document.getElementById("tbMarkerMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteMid").value = parseInt(document.getElementById("tbIncompleteMid").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishMid").value = parseInt(document.getElementById("tbFitFinishMid").value) + 1;
                    }
                }

                if (rear.isHitBy(touchX, touchY)) {
                    console.log('Rear');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsRear").value = parseInt(document.getElementById("tbDentsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsRear").value = parseInt(document.getElementById("tbCartDentsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesRear").value = parseInt(document.getElementById("tbScratchesRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterRear").value = parseInt(document.getElementById("tbSplatterRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustRear").value = parseInt(document.getElementById("tbDustRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsRear").value = parseInt(document.getElementById("tbBurnsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerRear").value = parseInt(document.getElementById("tbMarkerRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteRear").value = parseInt(document.getElementById("tbIncompleteRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishRear").value = parseInt(document.getElementById("tbFitFinishRear").value) + 1;
                    }
                }

                if (rear2.isHitBy(touchX, touchY)) {
                    console.log('Rear');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsRear").value = parseInt(document.getElementById("tbDentsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsRear").value = parseInt(document.getElementById("tbCartDentsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesRear").value = parseInt(document.getElementById("tbScratchesRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterRear").value = parseInt(document.getElementById("tbSplatterRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustRear").value = parseInt(document.getElementById("tbDustRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsRear").value = parseInt(document.getElementById("tbBurnsRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerRear").value = parseInt(document.getElementById("tbMarkerRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteRear").value = parseInt(document.getElementById("tbIncompleteRear").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishRear").value = parseInt(document.getElementById("tbFitFinishRear").value) + 1;
                    }
                }

                if (endcap.isHitBy(touchX, touchY)) {
                    console.log('EndCap');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsEndCap").value = parseInt(document.getElementById("tbDentsEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsEndCap").value = parseInt(document.getElementById("tbCartDentsEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesEndCap").value = parseInt(document.getElementById("tbScratchesEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterEndCap").value = parseInt(document.getElementById("tbSplatterEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustEndCap").value = parseInt(document.getElementById("tbDustEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsEndCap").value = parseInt(document.getElementById("tbBurnsEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerEndCap").value = parseInt(document.getElementById("tbMarkerEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteEndCap").value = parseInt(document.getElementById("tbIncompleteEndCap").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishEndCap").value = parseInt(document.getElementById("tbFitFinishEndCap").value) + 1;
                    }
                }

                if (nosecone.isHitBy(touchX, touchY)) {
                    console.log('Nose Cone');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsNoseCone").value = parseInt(document.getElementById("tbDentsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsNoseCone").value = parseInt(document.getElementById("tbCartDentsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesNoseCone").value = parseInt(document.getElementById("tbScratchesNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterNoseCone").value = parseInt(document.getElementById("tbSplatterNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustNoseCone").value = parseInt(document.getElementById("tbDustNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsNoseCone").value = parseInt(document.getElementById("tbBurnsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerNoseCone").value = parseInt(document.getElementById("tbMarkerNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteNoseCone").value = parseInt(document.getElementById("tbIncompleteNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishNoseCone").value = parseInt(document.getElementById("tbFitFinishNoseCone").value) + 1;
                    }
                }

                if (nosecone2.isHitBy(touchX, touchY)) {
                    console.log('Nose Cone');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbDentsNoseCone").value = parseInt(document.getElementById("tbDentsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbCartDentsNoseCone").value = parseInt(document.getElementById("tbCartDentsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "orange") {
                        document.getElementById("tbScratchesNoseCone").value = parseInt(document.getElementById("tbScratchesNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkorchid") {
                        document.getElementById("tbSplatterNoseCone").value = parseInt(document.getElementById("tbSplatterNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkkhaki") {
                        document.getElementById("tbDustNoseCone").value = parseInt(document.getElementById("tbDustNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "lawngreen") {
                        document.getElementById("tbBurnsNoseCone").value = parseInt(document.getElementById("tbBurnsNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "skyblue") {
                        document.getElementById("tbMarkerNoseCone").value = parseInt(document.getElementById("tbMarkerNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbIncompleteNoseCone").value = parseInt(document.getElementById("tbIncompleteNoseCone").value) + 1;
                    } else if (document.getElementById('selColor').value === "darkblue") {
                        document.getElementById("tbFitFinishNoseCone").value = parseInt(document.getElementById("tbFitFinishNoseCone").value) + 1;
                    }
                }



            }, false);
        }


        function ConvertToImage(btnSave) {
            var base64 = $('#myCanvas')[0].toDataURL();
            $("[id*=hfImageData]").val(base64);
            __doPostBack(btnSave.name, "");
        };
    </script>

</head>
<body onload="init();">

    <form id="form1" runat="server">
        <div id="content">
            <div id="header">
               <asp:Table ID="Table1" runat="server" CssClass="newStyle1" Width="762px">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label18" runat="server" Text="Prod #: " CssClass="newStyle4" Width="90px"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tbProd" runat="server" CssClass="auto-style1" Width="116px"></asp:TextBox><br />
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label ID="Label8" runat="server" Text="Tube:" CssClass="newStyle4"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:RadioButtonList ID="rblTube" runat="server" AutoPostBack="True">
                                <asp:ListItem>PORT</asp:ListItem>
                                <asp:ListItem>STRB</asp:ListItem>
                                <asp:ListItem>CTR</asp:ListItem>
                            </asp:RadioButtonList>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TableCell runat="server">
                                <asp:Label ID="Label12" runat="server" Text="Location:" CssClass="newStyle4"></asp:Label>
                            </asp:TableCell>
                        </asp:TableCell>
                        <asp:TableCell runat="server">
                            <asp:DropDownList ID="ddlWorkstation" runat="server" AutoPostBack="True">
                                <asp:ListItem Value="NotSet">Select Current Workstation</asp:ListItem>
                                <asp:ListItem>North Pre Framing</asp:ListItem>
                                <asp:ListItem>Frame Stack</asp:ListItem>
                                <asp:ListItem>Decks Outside</asp:ListItem>
                                <asp:ListItem>Frames</asp:ListItem>
                                <asp:ListItem>Floors</asp:ListItem>
                                <asp:ListItem>Trim</asp:ListItem>
                                <asp:ListItem>Rails</asp:ListItem>
                                <asp:ListItem>Furniture</asp:ListItem>
                                <asp:ListItem>Helms</asp:ListItem>
                                <asp:ListItem>Inspection</asp:ListItem>
                                <asp:ListItem Value="Final">Final Inspection</asp:ListItem>
                                <asp:ListItem>Shrinkwrap</asp:ListItem>
                                <asp:ListItem>Rigging</asp:ListItem>
                                <asp:ListItem>Wavetamer</asp:ListItem>
                                <asp:ListItem>Sharkhide</asp:ListItem>
                                <asp:ListItem>Yard</asp:ListItem>

                            </asp:DropDownList>
                        </asp:TableCell>

                    </asp:TableRow>
                </asp:Table>
            </div>
            <div id="drawingbuttons">
                <br />
                <button onclick="javascript:clearArea();return false;">Clear Drawing</button>
                &nbsp;&nbsp;
            <button onclick="javascript:cUndo();return false;">Undo</button>
                &nbsp;&nbsp;            
            <button onclick="javascript:cRedo();return false;">Redo</button>
            </div>
            <div id="drawing">
                <canvas id="myCanvas" width="800" height="250" style="border: 0px solid black"></canvas>
                <br />


                <select id="selWidth" hidden="hidden">
                    <option value="1">1</option>
                    <option value="3">3</option>
                    <option value="5">5</option>
                    <option value="7">7</option>
                    <option value="4" selected="selected">4</option>
                    <option value="11">11</option>
                </select>&nbsp;
            <select id="selColor" hidden="hidden">
                <option value="blue">Dents</option>
                <option value="green">Cart Dents</option>
                <option value="orange">Scratches</option>
                <option value="darkorchid">Splatter</option>
                <option value="darkkhaki">Dust</option>
                <option value="lawngreen">Burns</option>
                <option value="skyblue">Marker</option>
                <option value="red">Incomplete Welds</option>
                <option value="darkblue">Fit and Finish</option>
            </select>

            </div>
            <div id="stations" class="newStyle8">
                <asp:Label ID="Label26" runat="server" Text="Workstations" CssClass="greensmall"></asp:Label>
                <br />
                <asp:Label ID="Label7" runat="server" Text="Inspect: " Width="100px"></asp:Label><asp:Label ID="lblInspect" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label1" runat="server" Text="Baffle: " Width="100px"></asp:Label><asp:Label ID="lblBaffle" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label3" runat="server" Text="Brackets: " Width="100px"></asp:Label><asp:Label ID="lblBrackets" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label4" runat="server" Text="Seamer: " Width="100px"></asp:Label><asp:Label ID="lblSeamer" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label2" runat="server" Text="Air Check 1: " Width="100px"></asp:Label><asp:Label ID="lblAircheck1" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label13" runat="server" Text="Repair 1: " Width="100px"></asp:Label><asp:Label ID="lblRepair1" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label11" runat="server" Text="Air Check 2: " Width="100px"></asp:Label><asp:Label ID="lblAircheck2" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label15" runat="server" Text="Repair 2: " Width="100px"></asp:Label><asp:Label ID="lblRepair2" runat="server" Text="" CssClass="newStyle8"></asp:Label>
            </div>
            <br />
            <div id="buildinst" class="newStyle8">
                <asp:Label ID="Label20" runat="server" Text="Build Instructions" CssClass="greensmall"></asp:Label>
                <br />                
                <asp:Label ID="Label21" runat="server" Text="Splash:" Width="100px" ></asp:Label><asp:Label ID="lblSplashInst" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label24" runat="server" Text="Ladder:" Width="100px" ></asp:Label><asp:Label ID="lblLadderInst" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label22" runat="server" Text="Fuel:" Width="100px" ></asp:Label><asp:Label ID="lblFuelInst" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label25" runat="server" Text="Chines/Foils:" Width="100px" ></asp:Label><asp:Label ID="lblChinesFoils" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label27" runat="server" Text="Storage:" Width="100px" ></asp:Label><asp:Label ID="lblStorage" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
                <asp:Label ID="Label6" runat="server" Text="Upsweep:"  Width="100px"></asp:Label><asp:Label ID="lblUpsweep" runat="server" Text="" CssClass="newStyle8"></asp:Label><br />
            </div>
            <div id="areas">
                <asp:Label ID="Label5" runat="server" Text="Areas With Issues" CssClass="newStyle4"></asp:Label>

                <br />
                <asp:Table ID="tblAreas" runat="server" CssClass="newStyle6" BorderStyle="Solid" BorderWidth="1px" GridLines="Both" Width="841px">
                    <asp:TableRow runat="server">
                        <asp:TableCell></asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="90px" CssClass="dents">
                           <button onclick="javascript:dents();return false;" class="dents">Dents</button>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="90px" CssClass="cartdents">
                            <button onclick="javascript:cartdents();return false;" class="cartdents">Cart Dents</button>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="100px" CssClass="scratches">
                            <button onclick="javascript:scratches();return false;" class="scratches">Scratches</button>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="140px" CssClass="splatter">
                            <button onclick="javascript:splatter();return false;" class="splatter">Splatter</button>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="100px" CssClass="dust">
                           <button onclick="javascript:dust();return false;" class="dust">Weld Dust</button>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="100px" CssClass="burns">
                            <button onclick="javascript:burns();return false;" class="burns">Burns</button>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="130px" CssClass="marks">
                            <button onclick="javascript:marks();return false;" class="marks">Marker Marks</button>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="140px" CssClass="incompletewelds">
                           <button onclick="javascript:incompletewelds();return false;" class="incompletewelds">Weld Completion</button>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="100px" CssClass="fitandfinish">
                              <button onclick="javascript:fitandfinish();return false;" class="fitandfinish">Fit & Finish</button>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="90px">
                            <asp:Label ID="Label16" runat="server" CssClass="newStyle5" Text="Front" Width="90px"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDentsFront" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbCartDentsFront" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbScratchesFront" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbSplatterFront" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDustFront" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbBurnsFront" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbMarkerFront" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbIncompleteFront" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbFitFinishFront" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label9" runat="server" CssClass="newStyle5" Text="Mid" Width="120px"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDentsMid" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbCartDentsMid" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbScratchesMid" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbSplatterMid" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDustMid" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbBurnsMid" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbMarkerMid" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbIncompleteMid" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbFitFinishMid" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label10" runat="server" CssClass="newStyle5" Text="Rear" Width="120px"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDentsRear" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbCartDentsRear" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbScratchesRear" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbSplatterRear" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDustRear" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbBurnsRear" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbMarkerRear" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbIncompleteRear" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbFitFinishRear" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label23" runat="server" CssClass="newStyle5" Text="End Cap" Width="120px"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDentsEndCap" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbCartDentsEndCap" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbScratchesEndCap" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbSplatterEndCap" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDustEndCap" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbBurnsEndCap" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbMarkerEndCap" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbIncompleteEndCap" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbFitFinishEndCap" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label14" runat="server" CssClass="newStyle5" Text="Nose Cone" Width="120px"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDentsNoseCone" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbCartDentsNoseCone" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbScratchesNoseCone" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbSplatterNoseCone" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbDustNoseCone" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbBurnsNoseCone" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbMarkerNoseCone" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbIncompleteNoseCone" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbFitFinishNoseCone" runat="server" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>

                <asp:HiddenField ID="hfImageData" runat="server" />
                <br />
               <asp:Label ID="Label17" runat="server" Text="Comments:" CssClass="newStyle4"></asp:Label>&nbsp;&nbsp;&nbsp;<asp:TextBox ID="tbComments" runat="server" CssClass="auto-style3" Height="42px" Width="780px"></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="btnSave" Text="Save" runat="server" UseSubmitBehavior="false" OnClick="Save" OnClientClick="return ConvertToImage(this)" CssClass="auto-style2" Height="48px" Width="101px" Enabled="True" />
                <br />
                <br />
                <asp:PlaceHolder ID="phPreviousInspections" runat="server">
                   <asp:Label ID="Label19" runat="server" Text=" Previous Inspections" CssClass="newStyle6"></asp:Label>
                </asp:PlaceHolder>
            </div>



        </div>
    </form>
</body>
</html>

