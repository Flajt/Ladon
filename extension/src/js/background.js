"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const webextension_polyfill_1 = __importDefault(require("webextension-polyfill"));
webextension_polyfill_1.default.webNavigation.onDOMContentLoaded.addListener((parameter) => {
    console.log("HAHAHA");
});
