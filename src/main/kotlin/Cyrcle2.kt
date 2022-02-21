import hype.H
import hype.HDrawablePool
import hype.HImage
import hype.HShape
import hype.extended.colorist.HColorPool
import hype.extended.layout.HShapeLayout
import processing.core.PApplet
import processing.core.PGraphics
import java.awt.Color


class Cyrcle2 : PApplet() {
    private lateinit var colorPool: HColorPool

    private val imageFileName = "cyrcle2-render.png"
    private val vectorFileName = "cyrcle2-vrender.pdf"
    private val saveImg = true
    private val saveVct = false
    private val scaleFactor = 4

    override fun settings() {
        size(1200, 1200)
        smooth()
        noLoop()
    }

    override fun setup() {
        H.init(this)
        H.background(Color(0x050505).rgb)
        colorPool = HColorPool(
            Color(0xEC02EC).rgb,
            Color(0xA1029F).rgb,
            Color(0x53044C).rgb,
            Color(0x830270).rgb,
            Color(0xEA00A0).rgb,
            Color(0xB5014F).rgb,
            Color(0xF862A3).rgb,
            Color(0xF10063).rgb,
            Color(0x822A4B).rgb,
            Color(0xB3032B).rgb,
            Color(0xFB0401).rgb,
            Color(0xD32C02).rgb,
            Color(0xAF2C01).rgb,
            Color(0x862802).rgb,
            Color(0x0208BC).rgb,
            Color(0x0526E6).rgb,
            Color(0x070B49).rgb,
            Color(0x320479).rgb,
            Color(0x3301BC).rgb,
            Color(0x0054F1).rgb,
            Color(0x0384FF).rgb,
            Color(0x5E14E6).rgb,
            Color(0x580A89).rgb,
            Color(0xA30EE8).rgb,
            Color(0x5F54ED).rgb,
            Color(0x382674).rgb,
            Color(0x9E5AF5).rgb,
            Color(0xE757F0).rgb,
            Color(0xA949AD).rgb,
            Color(0x9E99FC).rgb
        )

        drawBackground(50000, 10)
        drawBackground(5000, 50)
        drawBackground(1000, 175)
        drawBackground(1000, 175, "edge-mask.png")
        drawBackground(100)

        if (saveVct) {
            saveVector()
        }

        if (saveImg) {
            saveHiRes(scaleFactor)
        }
    }

    override fun draw() {
        H.drawStage()
    }

    fun drawBackground(count: Int, alpha: Int = 0, maskFile: String? = null) {
        val backgroundPool = HDrawablePool(count).autoAddToStage()
            .add(HShape("cyrcle1.svg").resetSize())
            .add(HShape("cyrcle2.svg").resetSize())
            .add(HShape("cyrcle3.svg").resetSize())
            .add(HShape("cyrcle4.svg").resetSize())
            .add(HShape("cyrcle5.svg").resetSize())
            .add(HShape("cyrcle6.svg").resetSize())
            .add(HShape("cyrcle7.svg").resetSize())
            .onCreate { obj ->
                val d = obj as HShape
                d
                    .enableStyle(false)
                    .strokeJoin(ROUND)
                    .strokeCap(ROUND)
                    .strokeWeight(1f)
                    .stroke(Color(0x000000).rgb)
                    .fill(0)
                    .anchorAt(H.CENTER)
                    .size(random(20f, 150f))
                    .alpha(alpha)

                if (maskFile == null) {
                    d.loc(random(width.toFloat()), random(height.toFloat()))
                }
                d.randomColors(colorPool.fillOnly())

            }
        if (maskFile != null) {
            backgroundPool.layout(HShapeLayout().target(HImage(maskFile)))
        }
        backgroundPool.requestAll()
    }
    fun saveVector() {
        val tmp: PGraphics? = beginRecord(PDF, vectorFileName)
        if (tmp == null) {
            H.drawStage()
        } else {
            H.stage().paintAll(tmp, false, 1f) // PGrpahics, uses3D, alpha
        }
        endRecord()
    }
    fun saveHiRes(scaleFactor: Int) {
        val hires = createGraphics(width * scaleFactor, height * scaleFactor, JAVA2D)
        beginRecord(hires)
        hires?.scale(scaleFactor.toFloat())
        if (hires == null) {
            H.drawStage()
        } else {
            H.stage().paintAll(hires, false, 1f) // PGrpahics, uses3D, alpha
        }
        endRecord()
        hires.save("render/$imageFileName")
    }
}