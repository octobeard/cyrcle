import processing.pdf.*;
import hype.*;
import hype.extended.colorist.*;

HDrawablePool pool;
HColorPool colorPool;

void setup() {
    size(1200,1200);
    H.init(this).background(#050505);
    smooth();

    colorPool = new HColorPool(#EC02EC,#A1029F,#53044C,#830270,#EA00A0,#B5014F,#F862A3,#F10063,#822A4B,#B3032B,#FB0401,#D32C02,#AF2C01,#862802,#0208BC,#0526E6,#070B49,#320479,#3301BC,#0054F1,#0384FF,#5E14E6,#580A89,#A30EE8,#5F54ED,#382674,#9E5AF5,#E757F0,#A949AD,#9E99FC);

    pool = new HDrawablePool(2000).autoAddToStage()
        .add(new HShape("cyrcle1.svg"))
        .add(new HShape("cyrcle2.svg").resetSize())
        .add(new HShape("cyrcle3.svg").resetSize())
        .add(new HShape("cyrcle4.svg").resetSize())
        .add(new HShape("cyrcle5.svg").resetSize())
        .add(new HShape("cyrcle6.svg").resetSize())
        .add(new HShape("cyrcle7.svg").resetSize())
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
                        .fill(colorPool.getColor(), 100)
                        .anchorAt(H.CENTER)
                        .loc((int) random(width), (int) random(height))
                        .size((int) random(20, 1150))
                        //.alpha(100)
                    ;

                    d.randomColors(colorPool.fillOnly());
                    //colors.applyColor(d);
                    //colorist.applyColor(d);
                }
            }

        )
        .requestAll()
    ;
    //saveVector();
    //saveHiRes(2);
    noLoop();
}

void draw() {
    H.drawStage();
}

void saveVector() {
    PGraphics tmp = null;

    tmp = beginRecord(PDF, "render.pdf");

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

    hires.save("accident2.png");
}