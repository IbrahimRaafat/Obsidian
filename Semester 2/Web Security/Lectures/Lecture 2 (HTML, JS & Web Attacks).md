---
annotation-target: "![[html-js.pdf]]"
---
-revisit lecture recording for scoping part

# Scoping in Java Script
- Scoping is in function level not Block Level
- JS Engine creates a new scope for each encountered function
- Enforce block scoping using **let**


# Variable and Function Hoisting
- calling a function before definition (hoistng)
-

# Dynamic Typing
```javascript
let value=42; //Number type
value="Javascipt"; // String Type
```

# Type Coercion
```javascript
let result=10+"5"
```

# Duck Typing
```javascript
funtion printName(obj){
console.log(obj.name);
}

let person={name:John, age=30};
let dog={name:"Bobby", breed:"akita"}
let book={title:"}
```

# Type Juggling Vulnerabilities
- in this example you have a string `foo` compared to an array with one item `"foo"`
```javascript
"foo" ==["foo"] //true **type coercion
"foo" ===["foo"] //false **no type coercion
```

# Eval and Friends
```javascript
let x+10;
let y=eval("x+5"); //y=15
```

# JSON
```javascript

```

# XMLHttpRequest(XHR)

```javascript

```

# Fetch API


# Inheritance in JS


# Prototype Pollution

