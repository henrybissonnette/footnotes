$(document).ready(function(){var a=1;$("#focal_item").load(function(){a-=1,a&&window.location.replace(this.contentWindow.location.href.replace("overlay/proxy?","overlay?"))})});