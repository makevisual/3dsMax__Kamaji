-- Define the struct
struct MyStruct
(
    myVar,  -- a variable

    -- function with an argument
    fn myFunc arg =
    (
        format "myVar = %, argument = %\n" myVar arg
    )
)

-- Instantiate the struct
myInstance = MyStruct myVar:42

-- Call the function with an argument
myInstance.myFunc "hello world"
