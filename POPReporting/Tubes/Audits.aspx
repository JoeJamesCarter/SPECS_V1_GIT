<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Audits.aspx.vb" Inherits="Tubes_Audits" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tube Audits</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js" type="text/javascript"></script>
    <link href="../StyleSheet.css" rel="stylesheet" />
    <style>
        #stations {
            width: 229px;
            float: left;
            margin-right: 10px;
            margin-bottom: 23px;
            height: 279px;
        }

        #drawing {
            width: 800px;
            margin-top: 20px;
            float: left;
            height: 263px;
        }

        #areas {
            width: 1000px;
            float: left;
        }

        .unmarked {
            background-color: blue;
            color: white;
            text-align:center;
        }

        .marked {
            background-color: green;
            color: white;
            text-align:center;
        }

        .missed {
            background-color: red;
            color: white;
            text-align:center;
        }

        #content {
            width: 1100px;
            height: 465px;
        }
        .auto-style1 {}
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
            background.src = "../Images/tubeaudit.png";

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

        function unmarked() {
            document.getElementById("selColor").value = "blue"
        }

        function marked() {
            document.getElementById("selColor").value = "green"
        }

        function missed() {
            document.getElementById("selColor").value = "red"
        }

        function initTextboxes() {
            document.getElementById("tbRSUnmarked").value = 0
            document.getElementById("tbRSMarked").value = 0
            document.getElementById("tbRSMissed").value = 0

            document.getElementById("tbTransomUnmarked").value = 0
            document.getElementById("tbTransomMarked").value = 0
            document.getElementById("tbTransomMissed").value = 0

            document.getElementById("tbPreweldUnmarked").value = 0
            document.getElementById("tbPreweldMarked").value = 0
            document.getElementById("tbPreweldMissed").value = 0


            document.getElementById("tbBracketsUnmarked").value = 0
            document.getElementById("tbBracketsMarked").value = 0
            document.getElementById("tbBracketsMissed").value = 0

            document.getElementById("tbKeelUnmarked").value = 0
            document.getElementById("tbKeelMarked").value = 0
            document.getElementById("tbKeelMissed").value = 0

            document.getElementById("tbEndcapUnmarked").value = 0
            document.getElementById("tbEndcapMarked").value = 0
            document.getElementById("tbEndcapMissed").value = 0

            document.getElementById("tbNoseconeUnmarked").value = 0
            document.getElementById("tbNoseconeMarked").value = 0
            document.getElementById("tbNoseconeMissed").value = 0

            document.getElementById("tbSplashUnmarked").value = 0
            document.getElementById("tbSplashMarked").value = 0
            document.getElementById("tbSplashMissed").value = 0

            document.getElementById("tbTopseamUnmarked").value = 0
            document.getElementById("tbTopseamMarked").value = 0
            document.getElementById("tbTopseamMissed").value = 0
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

            var roundseamer1 = new Rectangle(342, 35, 20, 120);
            var roundseamer2 = new Rectangle(595, 35, 20, 120)
            var keel = new Rectangle(100, 150, 500, 25)
            var endcap = new Rectangle(88, 30, 20, 130)
            var transom = new Rectangle(65, 20, 15, 80)
            var nosecone = new Rectangle(620, 35, 90, 120)
            var splash = new Rectangle(620, 110, 50, 30)
            var topseam = new Rectangle(110, 50, 480, 15)
            var brackets1 = new Rectangle(112, 100, 90, 15)
            var brackets2 = new Rectangle(240, 100, 100, 15)
            var brackets3 = new Rectangle(375, 100, 220, 15)


            var preweld = new Circle(48, 132, 18);

            ctx.strokeRect(roundseamer1.x, roundseamer1.y, roundseamer1.width, roundseamer1.height);
            ctx.strokeRect(roundseamer2.x, roundseamer2.y, roundseamer2.width, roundseamer2.height);
            ctx.strokeRect(keel.x, keel.y, keel.width, keel.height);
            ctx.strokeRect(endcap.x, endcap.y, endcap.width, endcap.height);
            ctx.strokeRect(transom.x, transom.y, transom.width, transom.height);
            ctx.strokeRect(nosecone.x, nosecone.y, nosecone.width, nosecone.height);
            ctx.strokeRect(splash.x, splash.y, splash.width, splash.height);
            ctx.strokeRect(topseam.x, topseam.y, topseam.width, topseam.height);
            ctx.strokeRect(brackets1.x, brackets1.y, brackets1.width, brackets1.height);
            ctx.strokeRect(brackets2.x, brackets2.y, brackets2.width, brackets2.height);
            ctx.strokeRect(brackets3.x, brackets3.y, brackets3.width, brackets3.height);

            ctx.beginPath();
            ctx.arc(preweld.x, preweld.y, preweld.radius, 0, Math.PI * 2);
            ctx.stroke();

            canvas.addEventListener('click', function (e) {
                var canvasBounds = canvas.getBoundingClientRect();

                var clickX = e.pageX - canvasBounds.left;
                var clickY = e.pageY - canvasBounds.top;

                //console.log(clickX);
                //console.log(clickY);

                if (roundseamer1.isHitBy(clickX, clickY)) {
                    console.log('Round Seamer');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbRSUnmarked").value = parseInt(document.getElementById("tbRSUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbRSMarked").value = parseInt(document.getElementById("tbRSMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbRSMissed").value = parseInt(document.getElementById("tbRSMissed").value) + 1;
                    }

                }

                if (roundseamer2.isHitBy(clickX, clickY)) {
                    console.log('Round Seamer 2');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbRSUnmarked").value = parseInt(document.getElementById("tbRSUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbRSMarked").value = parseInt(document.getElementById("tbRSMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbRSMissed").value = parseInt(document.getElementById("tbRSMissed").value) + 1;
                    }
                }

                if (keel.isHitBy(clickX, clickY)) {
                    console.log('Keel');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbKeelUnmarked").value = parseInt(document.getElementById("tbKeelUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbKeelMarked").value = parseInt(document.getElementById("tbKeelMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbKeelMissed").value = parseInt(document.getElementById("tbKeelMissed").value) + 1;
                    }
                }

                if (endcap.isHitBy(clickX, clickY)) {
                    console.log('End Cap');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbEndcapUnmarked").value = parseInt(document.getElementById("tbEndcapUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbEndcapMarked").value = parseInt(document.getElementById("tbEndcapMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbEndcapMissed").value = parseInt(document.getElementById("tbEndcapMissed").value) + 1;
                    }
                }

                if (transom.isHitBy(clickX, clickY)) {
                    console.log('Transom');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbTransomUnmarked").value = parseInt(document.getElementById("tbTransomUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbTransomMarked").value = parseInt(document.getElementById("tbTransomMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbTransomMissed").value = parseInt(document.getElementById("tbTransomMissed").value) + 1;
                    }
                }

                if (nosecone.isHitBy(clickX, clickY)) {
                    console.log('Nose Cone');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbNoseconeUnmarked").value = parseInt(document.getElementById("tbNoseconeUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbNoseconeMarked").value = parseInt(document.getElementById("tbNoseconeMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbNoseconeMissed").value = parseInt(document.getElementById("tbNoseconeMissed").value) + 1;
                    }
                }

                // Test preweld for hit
                if (preweld.isHitBy(clickX, clickY)) {
                    console.log('PreWeld hit');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbPreweldUnmarked").value = parseInt(document.getElementById("tbPreweldUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbPreweldMarked").value = parseInt(document.getElementById("tbPreweldMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbPreweldMissed").value = parseInt(document.getElementById("tbPreweldMissed").value) + 1;
                    }

                }

                if (topseam.isHitBy(clickX, clickY)) {
                    console.log('Top Seam');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbTopseamUnmarked").value = parseInt(document.getElementById("tbTopseamUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbTopseamMarked").value = parseInt(document.getElementById("tbTopseamMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbTopseamMissed").value = parseInt(document.getElementById("tbTopseamMissed").value) + 1;
                    }

                }

                if (splash.isHitBy(clickX, clickY)) {
                    console.log('Splash');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbSplashUnmarked").value = parseInt(document.getElementById("tbSplashUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbSplashMarked").value = parseInt(document.getElementById("tbSplashMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbSplashMissed").value = parseInt(document.getElementById("tbSplashMissed").value) + 1;
                    }

                }
                if (brackets1.isHitBy(clickX, clickY)) {
                    console.log('Brackets');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbBracketsUnmarked").value = parseInt(document.getElementById("tbBracketsUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbBracketsMarked").value = parseInt(document.getElementById("tbBracketsMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbBracketsMissed").value = parseInt(document.getElementById("tbBracketsMissed").value) + 1;
                    }

                }

                if (brackets2.isHitBy(clickX, clickY)) {
                    console.log('Brackets');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbBracketsUnmarked").value = parseInt(document.getElementById("tbBracketsUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbBracketsMarked").value = parseInt(document.getElementById("tbBracketsMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbBracketsMissed").value = parseInt(document.getElementById("tbBracketsMissed").value) + 1;
                    }

                }

                if (brackets3.isHitBy(clickX, clickY)) {
                    console.log('Brackets');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbBracketsUnmarked").value = parseInt(document.getElementById("tbBracketsUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbBracketsMarked").value = parseInt(document.getElementById("tbBracketsMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbBracketsMissed").value = parseInt(document.getElementById("tbBracketsMissed").value) + 1;
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

                if (roundseamer1.isHitBy(touchX, touchY)) {
                    console.log('Round Seamer');

                    //document.getElementById("cbRoundSeamer").checked = true;

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbRSUnmarked").value = parseInt(document.getElementById("tbRSUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbRSMarked").value = parseInt(document.getElementById("tbRSMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbRSMissed").value = parseInt(document.getElementById("tbRSMissed").value) + 1;
                    }

                }

                if (roundseamer2.isHitBy(touchX, touchY)) {
                    console.log('Round Seamer 2');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbRSUnmarked").value = parseInt(document.getElementById("tbRSUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbRSMarked").value = parseInt(document.getElementById("tbRSMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbRSMissed").value = parseInt(document.getElementById("tbRSMissed").value) + 1;
                    }
                }

                if (keel.isHitBy(touchX, touchY)) {
                    console.log('Keel');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbKeelUnmarked").value = parseInt(document.getElementById("tbKeelUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbKeelMarked").value = parseInt(document.getElementById("tbKeelMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbKeelMissed").value = parseInt(document.getElementById("tbKeelMissed").value) + 1;
                    }
                }

                if (endcap.isHitBy(touchX, touchY)) {
                    console.log('End Cap');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbEndcapUnmarked").value = parseInt(document.getElementById("tbEndcapUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbEndcapMarked").value = parseInt(document.getElementById("tbEndcapMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbEndcapMissed").value = parseInt(document.getElementById("tbEndcapMissed").value) + 1;
                    }
                }

                if (transom.isHitBy(touchX, touchY)) {
                    console.log('Transom');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbTransomUnmarked").value = parseInt(document.getElementById("tbTransomUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbTransomMarked").value = parseInt(document.getElementById("tbTransomMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbTransomMissed").value = parseInt(document.getElementById("tbTransomMissed").value) + 1;
                    }
                }

                if (nosecone.isHitBy(touchX, touchY)) {
                    console.log('Nose Cone');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbNoseconeUnmarked").value = parseInt(document.getElementById("tbNoseconeUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbNoseconeMarked").value = parseInt(document.getElementById("tbNoseconeMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbNoseconeMissed").value = parseInt(document.getElementById("tbNoseconeMissed").value) + 1;
                    }
                }

                // Test preweld for hit
                if (preweld.isHitBy(touchX, touchY)) {
                    console.log('PreWeld hit');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbPreweldUnmarked").value = parseInt(document.getElementById("tbPreweldUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbPreweldMarked").value = parseInt(document.getElementById("tbPreweldMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbPreweldMissed").value = parseInt(document.getElementById("tbPreweldMissed").value) + 1;
                    }

                }

                if (topseam.isHitBy(touchX, touchY)) {
                    console.log('Top Seam');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbTopseamUnmarked").value = parseInt(document.getElementById("tbTopseamUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbTopseamMarked").value = parseInt(document.getElementById("tbTopseamMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbTopseamMissed").value = parseInt(document.getElementById("tbTopseamMissed").value) + 1;
                    }

                }

                if (splash.isHitBy(touchX, touchY)) {
                    console.log('Splash');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbSplashUnmarked").value = parseInt(document.getElementById("tbSplashUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbSplashMarked").value = parseInt(document.getElementById("tbSplashMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbSplashMissed").value = parseInt(document.getElementById("tbSplashMissed").value) + 1;
                    }

                }
                if (brackets1.isHitBy(touchX, touchY)) {
                    console.log('Brackets');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbBracketsUnmarked").value = parseInt(document.getElementById("tbBracketsUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbBracketsMarked").value = parseInt(document.getElementById("tbBracketsMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbBracketsMissed").value = parseInt(document.getElementById("tbBracketsMissed").value) + 1;
                    }

                }

                if (brackets2.isHitBy(touchX, touchY)) {
                    console.log('Brackets');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbBracketsUnmarked").value = parseInt(document.getElementById("tbBracketsUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbBracketsMarked").value = parseInt(document.getElementById("tbBracketsMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbBracketsMissed").value = parseInt(document.getElementById("tbBracketsMissed").value) + 1;
                    }

                }

                if (brackets3.isHitBy(touchX, touchY)) {
                    console.log('Brackets');

                    if (document.getElementById('selColor').value === "blue") {
                        document.getElementById("tbBracketsUnmarked").value = parseInt(document.getElementById("tbBracketsUnmarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "green") {
                        document.getElementById("tbBracketsMarked").value = parseInt(document.getElementById("tbBracketsMarked").value) + 1;
                    } else if (document.getElementById('selColor').value === "red") {
                        document.getElementById("tbBracketsMissed").value = parseInt(document.getElementById("tbBracketsMissed").value) + 1;
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
            <div id="stations" class="newStyle6">
                <asp:TextBox ID="tbProd" runat="server" CssClass="auto-style1" Width="186px" AutoPostBack="True"></asp:TextBox>
                <br />
                <asp:Label ID="Label6" runat="server" Text="Prod #: " CssClass="newStyle4" Width="90px"></asp:Label>
                <asp:Label ID="lblProd" runat="server"></asp:Label>
                <br />
                <asp:Label ID="Label8" runat="server" Text="Tube: " CssClass="newStyle4" Width="90px"></asp:Label><asp:Label ID="lblTube" runat="server" Text=""></asp:Label>
                <br />
                
                <br />
                <asp:Label ID="Label7" runat="server" Text="Inspect: " Width="100px"></asp:Label><asp:Label ID="lblInspect" runat="server" Text="" CssClass="newStyle1"></asp:Label><br />
                <asp:Label ID="Label1" runat="server" Text="Baffle: " Width="100px"></asp:Label><asp:Label ID="lblBaffle" runat="server" Text="" CssClass="newStyle1"></asp:Label><br />                
                <asp:Label ID="Label3" runat="server" Text="Brackets: " Width="100px"></asp:Label><asp:Label ID="lblBrackets" runat="server" Text="" CssClass="newStyle1"></asp:Label><br />
                <asp:Label ID="Label4" runat="server" Text="Seamer: " Width="100px"></asp:Label><asp:Label ID="lblSeamer" runat="server" Text="" CssClass="newStyle1"></asp:Label><br />
                <asp:Label ID="Label2" runat="server" Text="AirCheck 1: " Width="100px"></asp:Label><asp:Label ID="lblAircheck1" runat="server" Text="" CssClass="newStyle1"></asp:Label><br />
                <asp:Label ID="Label13" runat="server" Text="Repair 1: " Width="100px"></asp:Label><asp:Label ID="lblRepair1" runat="server" Text="" CssClass="newStyle1"></asp:Label><br />
                <asp:Label ID="Label11" runat="server" Text="AirCheck 2: " Width="100px"></asp:Label><asp:Label ID="lblAircheck2" runat="server" Text="" CssClass="newStyle1"></asp:Label><br />
                <asp:Label ID="Label15" runat="server" Text="Repair 2: " Width="100px"></asp:Label><asp:Label ID="lblRepair2" runat="server" Text="" CssClass="newStyle1"></asp:Label>
                <br />

            </div>
            <div id="drawing">
                <canvas id="myCanvas" width="715" height="200" style="border: 0px solid black"></canvas>
                <br />
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
                <option value="blue">Unmarked</option>
                <option value="green">Marked</option>
                <option value="red">Missed Welds</option>
            </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             
             <button onclick="javascript:unmarked();return false;" class="unmarked">Unmarked</button>
                <button onclick="javascript:marked();return false;" class="marked">Marked</button>
                <button onclick="javascript:missed();return false;" class="missed">Missed Welds</button>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button onclick="javascript:clearArea();return false;">Clear Drawing</button>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <button onclick="javascript:cUndo();return false;">Undo</button>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            
            <button onclick="javascript:cRedo();return false;">Redo</button>
                <br />

            </div>
            <div id="areas">
                <asp:Label ID="Label5" runat="server" Text="Areas With Issues" CssClass="newStyle4"></asp:Label>

                <br />
                <asp:Table ID="tblAreas" runat="server" CssClass="newStyle6" Width="996px" BorderStyle="Solid" BorderWidth="1px" GridLines="Both">
                    <asp:TableRow runat="server">
                        <asp:TableCell></asp:TableCell>
                         <asp:TableCell HorizontalAlign="center" Width="100px">
                            <asp:Label ID="Label22" runat="server" Text="Transom"></asp:Label>                            
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="100px">
                            <asp:Label ID="Label18" runat="server" Text="Pre Weld"></asp:Label>                            
                        </asp:TableCell>
                          <asp:TableCell HorizontalAlign="center" Width="100px" >
                            <asp:Label ID="Label14" runat="server" Text="Brackets"></asp:Label>                           
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="100px">
                            <asp:Label ID="Label12" runat="server" Text="Round Seam"></asp:Label>                            
                        </asp:TableCell>                      
                        <asp:TableCell HorizontalAlign="center" Width="100px">
                            <asp:Label ID="Label17" runat="server" Text="Keel"></asp:Label>                            
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="100px">
                            <asp:Label ID="Label20" runat="server" Text="End Cap"></asp:Label>                            
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center" Width="100px">
                            <asp:Label ID="Label19" runat="server" Text="Nose Cone"></asp:Label>                            
                        </asp:TableCell>                        
                        <asp:TableCell HorizontalAlign="center" Width="100px">
                            <asp:Label ID="Label21" runat="server" Text="Splash"></asp:Label>                            
                        </asp:TableCell>                       
                        <asp:TableCell HorizontalAlign="center" Width="100px">
                            <asp:Label ID="Label23" runat="server" Text="Top Seam"></asp:Label>                            
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell Width="90px">
                            <asp:Label ID="Label16" runat="server" CssClass="newStyle5" Text="Qty. Unmarked" Width="90px"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbTransomUnmarked" runat="server" CssClass="unmarked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbPreweldUnmarked" runat="server" CssClass="unmarked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbBracketsUnmarked" runat="server" CssClass="unmarked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbRSUnmarked" runat="server" CssClass="unmarked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbKeelUnmarked" runat="server" CssClass="unmarked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbEndcapUnmarked" runat="server" CssClass="unmarked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbNoseconeUnmarked" runat="server" CssClass="unmarked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbSplashUnmarked" runat="server" CssClass="unmarked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbTopseamUnmarked" runat="server" CssClass="unmarked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label9" runat="server" CssClass="newStyle5" Text="Qty. Marked" Width="120px"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbTransomMarked" runat="server" CssClass="marked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbPreweldMarked" runat="server" CssClass="marked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbBracketsMarked" runat="server" CssClass="marked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbRSMarked" runat="server" CssClass="marked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbKeelMarked" runat="server" CssClass="marked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbEndcapMarked" runat="server" CssClass="marked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbNoseconeMarked" runat="server" CssClass="marked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbSplashMarked" runat="server" CssClass="marked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbTopseamMarked" runat="server" CssClass="marked" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="Label10" runat="server" CssClass="newStyle5" Text="Qty. Missed Welds" Width="120px"></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbTransomMissed" runat="server" CssClass="missed" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbPreweldMissed" runat="server" CssClass="missed" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbBracketsMissed" runat="server" CssClass="missed" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbRSMissed" runat="server" CssClass="missed" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbKeelMissed" runat="server" CssClass="missed" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbEndcapMissed" runat="server" CssClass="missed" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbNoseconeMissed" runat="server" CssClass="missed" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbSplashMissed" runat="server" CssClass="missed" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="center">
                            <asp:TextBox ID="tbTopseamMissed" runat="server" CssClass="missed" Width="25px"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>                    
                </asp:Table>
                <br />

                <br />
               <asp:HiddenField ID="hfImageData" runat="server" />
               <asp:Button ID="btnSave" Text="Save" runat="server" UseSubmitBehavior="false" OnClick="Save" OnClientClick="return ConvertToImage(this)" />
                <br />
            </div>
        </div>
    </form>
</body>
</html>
