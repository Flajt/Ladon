import Browser from "webextension-polyfill";

Browser.webNavigation.onCompleted.addListener((details)=>{
    let input = document.getElementsByName("input")    
    const inputLenght = input.length;
    input.forEach((element)=>{
        if(element.inputMode == "input"){}
    })
});
