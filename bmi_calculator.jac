with entry {
    # User Input
    age_input = input("Enter your age: ");
    height_cm_input = input("Enter your height in cm: ");
    weight_kg_input = input("Enter your weight in kg: ");
    
    # Conversion
    age: int = int(age_input);
    height_cm: float = float(height_cm_input);
    weight_kg: float = float(weight_kg_input);
    
    # Variables
    message: str = "";
    
    if age < 20 {
        message = "You are still young, enjoy life while you can";
    } elif age > 64 {
        message = "You are now old, enjoy your old age/retirement";
    } else {
        height_m: float = height_cm / 100.0;  # Converting cm to meters
        bmi: float = weight_kg / (height_m * height_m);
        
        # BMI Categories
        category: str = "";
        if bmi < 18.5 {
            category = "Underweight";
        } elif bmi < 25.0 {
            category = "Normal weight";
        } elif bmi < 30.0 {
            category = "Overweight";
        } else {
            category = "Obese";
        }
        
        message = f"Your BMI is: {bmi} ({category})";
    }

    # Results Display 
    print("\n--- Results ---");
    print("Age:", age);
    print("Height:", height_cm, "cm");
    print("Weight:", weight_kg, "kg");
    print(message);
}

