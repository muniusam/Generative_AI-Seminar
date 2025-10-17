"""Scale-agnostic Unit Converter (no LLM)"""

# FIX: Define the node type 'turn' which is required by the walker definition.
node turn {} 

walker Converter {
    has value: float;
    has from_unit: str;
    has to_unit: str;

    # convert is an entry (callable locally or when served)
    can convert with turn entry;
}

# local demo: spawns a few examples when run locally
with entry:__main__ {
    // FIX: Capture the reported result and print it to the console.
    
    let result1 = root spawn Converter(value=1, from_unit="m", to_unit="cm");
    print(result1);

    let result2 = root spawn Converter(value=10, from_unit="kg", to_unit="lb");
    print(result2);
    
    let result3 = root spawn Converter(value=32, from_unit="F", to_unit="C");
    print(result3);
    
    let result4 = root spawn Converter(value=100, from_unit="C", to_unit="K");
    print(result4);
}