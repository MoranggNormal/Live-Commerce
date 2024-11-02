// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";

import Hooks from "./hooks/hooks";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  longPollFallbackMs: 2500,
  params: { _csrf_token: csrfToken },
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

// Change
var num = function (from, to) {
  return Math.floor(Math.random() * to) + from;
};

// return 2 digit
var el_2 = document.getElementsByClassName("num-2");
var display_2 = function () {
  for (let i = 0; i < el_2.length; i++) {
    const e = el_2[i];

    e.innerText = num(1, 99);
  }
};

if (el_2.length > 0) {
  display_2();
}
// end 2 digit

// return 3 digit
var el_3 = document.getElementsByClassName("num-3");
var display_3 = function () {
  for (let i = 0; i < el_3.length; i++) {
    const e = el_3[i];

    e.innerText = num(99, 999);
  }
};

if (el_3.length > 0) {
  display_3();
}
// end 3 digit

// return 4 digit
var el_4 = document.getElementsByClassName("num-4");
var display_4 = function () {
  for (let i = 0; i < el_4.length; i++) {
    const e = el_4[i];

    e.innerText = num(999, 9999);
  }
};

if (el_4.length > 0) {
  display_4();
}
// end 4 digits

var options2 = {
  chart: {
    width: "100%",
    type: "area",
    toolbar: {
      show: false,
    },
  },
  grid: {
    show: false,
    padding: {
      top: 0,
      right: 0,
      bottom: 0,
      left: 0,
    },
  },
  dataLabels: {
    enabled: false,
  },
  legend: {
    show: false,
  },
  series: [
    {
      name: "serie1",
      data: [44, 55, 41, 67, 22, 43, 21, 41, 56, 27, 43],
    },
    {
      name: "serie2",
      data: [54, 45, 51, 57, 32, 33, 31, 31, 46, 37, 33],
    },
  ],
  fill: {
    type: "gradient",
    gradient: {
      shadeIntensity: 1,
      opacityFrom: 0.9,
      opacityTo: 0.7,
      stops: [0, 90, 100],
    },
    colors: ["#4fd1c5"],
  },
  stroke: {
    colors: ["#4fd1c5"],
    width: 3,
  },
  yaxis: {
    show: false,
  },
  xaxis: {
    categories: [1, 2, 3, 4, 5, 6, 6, 7, 8, 9, 10],
    labels: {
      show: false,
    },
    axisBorder: {
      show: false,
    },
    tooltip: {
      enabled: false,
    },
  },
};

var SummaryChart = document.getElementById("SummaryChart");

if (SummaryChart != null && typeof SummaryChart != "undefined") {
  var chart = new ApexCharts(document.querySelector("#SummaryChart"), options2);
  chart.render();
}
