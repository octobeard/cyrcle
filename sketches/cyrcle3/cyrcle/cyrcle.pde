import processing.pdf.*;
import hype.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;

HColorPool colorPool, blueColorPool;

String imageFileName = "cyrcle-desktop6b.png";
String vectorFileName = "accident1.pdf";
boolean saveImg = true;
boolean saveVct = false;
int scaleFactor = 4;

void setup() {
    size(1920,1080);
    H.init(this).background(#050505);
    smooth();

    colorPool = new HColorPool(#EC02EC,#A1029F,#53044C,#830270,#EA00A0,#B5014F,#F862A3,#F10063,#822A4B,#B3032B,#FB0401,#D32C02,#AF2C01,#862802,#0208BC,#0526E6,#070B49,#320479,#3301BC,#0054F1,#0384FF,#5E14E6,#580A89,#A30EE8,#5F54ED,#382674,#9E5AF5,#E757F0,#A949AD,#9E99FC);
    
    blueColorPool = new HColorPool(#0208BC,#0526E6,#002CB8,#3301BC,#0054F1,#0384FF,#5F54ED);

    drawBackground(50000, 10, null);
    drawBackground(5000, 50, null);
    drawBackground(1000, 175, null);
    drawMiddle(5000, null, 50);
    drawMiddle(300, "center-mask-big-wide.png", 200);
    drawBackground(1000, 175, "edge-mask-wide.png");
    //drawBackground(1000, 175, null);
    //drawForeground(100);


    if (saveVct) {
        saveVector();        
    }

    if (saveImg) {
        saveHiRes(scaleFactor);
    }

    noLoop();
}

void draw() {
    H.drawStage();
}

void drawBackground(int count, int alpha, String maskFile) {
    // lol java wtf there's got to be a better way to pass scope into callbacks
    final int[] hackArray = new int[1];
    hackArray[0] = alpha;

    final String[] hackStringArray = new String[1];
    hackStringArray[0] = maskFile;

    HDrawablePool backgroundPool = new HDrawablePool(count);
    backgroundPool.autoAddToStage()
        .add(new HShape("cyrcle1.svg"))
        .add(new HShape("cyrcle2.svg"))
        .add(new HShape("cyrcle3.svg"))
        .add(new HShape("cyrcle4.svg"))
        .add(new HShape("cyrcle5.svg"))
        .add(new HShape("cyrcle6.svg"))
        .add(new HShape("cyrcle7.svg"))
        .onCreate(
            new HCallback() {
                public void run(Object obj) {
                    HShape d = (HShape) obj;
                    d 
                        .enableStyle(false)
                        .strokeJoin(ROUND)
                        .strokeCap(ROUND)
                        .strokeWeight(1)
                        .stroke(#000000)
                        .fill(0)
                        .anchorAt(H.CENTER)
                        .size((int) random(20, 150))
                        .alpha(hackArray[0]) // yeah I know
                    ;

                    if (hackStringArray[0] == null) {
                        d.loc((int) random(width), (int) random(height));
                    }
                    d.randomColors(colorPool.fillOnly());
                }
            }

        );
    if (maskFile != null) {
        backgroundPool.layout(
            new HShapeLayout()
                .target(
                    new HImage(maskFile)
                )
        );
    }
    backgroundPool.requestAll();
}

void drawForeground(int count) {
        HDrawablePool foregroundPool = new HDrawablePool(count).autoAddToStage()
        .add(new HShape("cyrcle1.svg"))
        .add(new HShape("cyrcle2.svg").resetSize())
        .add(new HShape("cyrcle3.svg").resetSize())
        .add(new HShape("cyrcle4.svg").resetSize())
        .add(new HShape("cyrcle5.svg").resetSize())
        .add(new HShape("cyrcle6.svg").resetSize())
        .add(new HShape("cyrcle7.svg").resetSize())
        .layout(
            new HShapeLayout()
                .target(
                    new HImage("edge-mask.png")
                )
        )
        .onCreate(
            new HCallback() {
                public void run(Object obj) {
                    HShape d = (HShape) obj;
                    d 
                        .enableStyle(false)
                        .strokeJoin(ROUND)
                        .strokeCap(ROUND)
                        .strokeWeight(1)
                        .stroke(#000000)
                        .fill(0)
                        .anchorAt(H.CENTER)
                        //.loc((int) random(width), (int) random(height))
                        .size((int) random(50, 300))
                        //.alpha(200)
                    ;

                    d.randomColors(colorPool.fillOnly());
                }
            }

        )
        .requestAll()
    ;
}

void drawMiddle(int count, String maskFile, int opacity) {
    final String[] hackStringArray = new String[1];
    hackStringArray[0] = maskFile;

    final int[] hackIntArray = new int[1];
    hackIntArray[0] = opacity;

    HDrawablePool middlePool = new HDrawablePool(count)
        .autoAddToStage()
        .add(new HShape("cyrcle1.svg"))
        .onCreate(
            new HCallback() {
                public void run(Object obj) {
                    HShape d = (HShape) obj;
                    d 
                        .enableStyle(false)
                        .strokeJoin(ROUND)
                        .strokeCap(ROUND)
                        .strokeWeight(1)
                        .stroke(#000000)
                        .fill(blueColorPool.getColor())
                        .anchorAt(H.CENTER)
                        .rotate((int) random(8) * 45)
                        .size(200 + ((int) random(4) * 50)) // 100, 150, 200, 250
                        .alpha(hackIntArray[0])
                    ;
                    if (hackStringArray[0] == null) {
                        d.loc((int) random(width), (int) random(height));
                    }

                }
            }

        );
    if (maskFile != null) {
        middlePool.layout(
            new HShapeLayout()
                .target(
                    new HImage(maskFile)
                )
        );
    }
    middlePool.requestAll();

}

void saveVector() {
    PGraphics tmp = null;

    tmp = beginRecord(PDF, vectorFileName);

    if (tmp == null) {
        H.drawStage();
    } else {
        H.stage().paintAll(tmp, false, 1); // PGrpahics, uses3D, alpha
    }
    endRecord();
}

void saveHiRes(int scaleFactor) {
    PGraphics hires = createGraphics(width*scaleFactor, height*scaleFactor, JAVA2D);
    beginRecord(hires);
    hires.scale(scaleFactor);
    if (hires == null) {
        H.drawStage();
    } else {
        H.stage().paintAll(hires, false, 1); // PGrpahics, uses3D, alpha
    }
    endRecord();

    hires.save(imageFileName);
}