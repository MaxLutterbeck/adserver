// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function clearDefault(el) {
if (el.defaultValue==el.value) el.value = ""
}

function replaceDefault(el) {
if (el.value.length==0) el.value = "Suchen ..."
}