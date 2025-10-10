impl Converter.convert(value: float, from_unit: str, to_unit: str) {
    # normalize unit strings
    let fu = lower(from_unit);
    let tu = lower(to_unit);

    # helper: convert to base unit (meters for length, kg for mass, C for temp)
    let cat = "unknown";
    if fu in ["m","meter","meters","cm","centimeter","centimeters","km","kilometer","kilometers","in","inch","inches","ft","feet","foot"] or
        tu in ["m","meter","meters","cm","centimeter","centimeters","km","kilometer","kilometers","in","inch","inches","ft","feet","foot"] {
        cat = "length"; // **FIXED: Semicolon added**
    } elif fu in ["kg","kilogram","kilograms","g","gram","grams","lb","pound","pounds","oz","ounce","ounces"] or
          tu in ["kg","kilogram","kilograms","g","gram","grams","lb","pound","pounds","oz","ounce","ounces"] {
        cat = "mass"; // **FIXED: Semicolon added**
    } elif fu in ["c","°c","celsius","f","°f","fahrenheit","k","°k","kelvin"] or
          tu in ["c","°c","celsius","f","°f","fahrenheit","k","°k","kelvin"] {
        cat = "temperature"; // **FIXED: Semicolon confirmed**
    }

    let result; // **FIXED: Colon changed to Semicolon**
    let steps = "";

    if cat == "length" {
        # convert any supported length to meters, then to target
        def to_m(v: float, u: str) -> float {
            let u = lower(u);
            if u in ["m","meter","meters"] { report v; }
            if u in ["cm","centimeter","centimeters"] { report v / 100.0; }
            if u in ["km","kilometer","kilometers"] { report v * 1000.0; }
            if u in ["in","inch","inches"] { report v * 0.0254; }
            if u in ["ft","feet","foot"] { report v * 0.3048; }
            # fallback
            report 0.0;
        }

        def m_to(v: float, u: str) -> float {
            let u = lower(u);
            if u in ["m","meter","meters"] { report v; }
            if u in ["cm","centimeter","centimeters"] { report v * 100.0; }
            if u in ["km","kilometer","kilometers"] { report v / 1000.0; }
            if u in ["in","inch","inches"] { report v / 0.0254; }
            if u in ["ft","feet","foot"] { report v / 0.3048; }
            report v;
        }

        let meters = to_m(value, fu);
        result = m_to(meters, tu);
        steps = f"{value} {from_unit} -> {meters} m -> {result} {to_unit}"; 
    } elif cat == "mass" {
        # convert any supported mass to kilograms, then to target
        def to_kg(v: float, u: str) -> float {
            let u = lower(u);
            if u in ["kg","kilogram","kilograms"] { report v; }
            if u in ["g","gram","grams"] { report v / 1000.0; }
            if u in ["lb","pound","pounds"] { report v * 0.45359237; }
            if u in ["oz","ounce","ounces"] { report v * 0.0283495231; }
            report 0.0;
        }

        def kg_to(v: float, u: str) -> float {
            let u = lower(u);
            if u in ["kg","kilogram","kilograms"] { report v; }
            if u in ["g","gram","grams"] { report v * 1000.0; }
            if u in ["lb","pound","pounds"] { report v / 0.45359237; }
            if u in ["oz","ounce","ounces"] { report v / 0.0283495231; }
            report v;
        }

        let kgs = to_kg(value, fu);
        result = kg_to(kgs, tu);
        steps = f"{value} {from_unit} -> {kgs} kg -> {result} {to_unit}"; 
    } elif cat == "temperature" {
        # handle temperature conversions precisely
        # normalize common tokens
        def n(u: str) -> str {
            let s = lower(u);
            if s in ["c","°c","celsius"] { report "c"; }
            if s in ["f","°f","fahrenheit"] { report "f"; }
            if s in ["k","°k","kelvin"] { report "k"; }
            report s;
        }

        let fu_n = n(fu);
        let tu_n = n(tu);

        def to_c(v: float, u: str) -> float {
            if u == "c" { report v; }
            if u == "f" { report (v - 32.0) * 5.0 / 9.0; }
            if u == "k" { report v - 273.15; }
            report v;
        }

        def c_to(v: float, u: str) -> float {
            if u == "c" { report v; }
            if u == "f" { report v * 9.0 / 5.0 + 32.0; }
            if u == "k" { report v + 273.15; }
            report v;
        }

        let cval = to_c(value, fu_n);
        result = c_to(cval, tu_n);
        steps = f"{value} {from_unit} -> {cval} °C -> {result} {to_unit}"; 
    } else {
        report { "error": "unsupported units or category" };
    }

    # return structured result and internal steps for inspection
    report { "result": result, "steps": steps };
}