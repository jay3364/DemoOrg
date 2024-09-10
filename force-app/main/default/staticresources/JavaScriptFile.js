//"Javascript program that will return an integer number corresponding to the amount of digits in the given integer num.
//Ex. num_of_digits(1000) ➞ 4
//num_of_digits(12) ➞ 2"

const prompt = require("prompt-sync")();

var num = parseInt( prompt("Enter the Number : "));
function number(){
   
    var values = num.toString();
    return values.length;
}
console.log(number());