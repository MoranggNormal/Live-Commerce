const MostSoldProductsChart = {
  mounted() {
    this.handleEvent("update_chart", ({ data }) => {
      const productsData = JSON.parse(data);
      const quantities = productsData.map((product) => product.total_quantity);
      const productNames = productsData.map((product) => product.name);

      const most_sold_products = document.getElementById("most_sold_products");
      const titleText = most_sold_products.getAttribute("data-title");
      const labelText = most_sold_products.getAttribute("data-quantity-label");

      const options = {
        series: [
          {
            name: labelText,
            data: quantities,
          },
        ],
        chart: {
          height: 350,
          type: "bar",
        },
        plotOptions: {
          bar: {
            borderRadius: 2,
            dataLabels: {
              position: "top",
            },
          },
        },
        dataLabels: {
          enabled: true,
          offsetY: -20,
          style: {
            fontSize: "12px",
            colors: ["#304758"],
          },
        },

        xaxis: {
          categories: productNames,
          position: "top",
          axisBorder: {
            show: false,
          },
          axisTicks: {
            show: false,
          },
          crosshairs: {
            fill: {
              type: "gradient",
              gradient: {
                colorFrom: "#D8E3F0",
                colorTo: "#BED1E6",
                stops: [0, 100],
                opacityFrom: 0.4,
                opacityTo: 0.5,
              },
            },
          },
          tooltip: {
            enabled: true,
          },
        },
        yaxis: {
          axisBorder: {
            show: false,
          },
          axisTicks: {
            show: false,
          },
          labels: {
            show: false,
          },
        },
        title: {
          text: titleText,
          floating: true,
          offsetY: 330,
          align: "center",
          style: {
            color: "#444",
          },
        },
      };

      const most_sold_products_chart = new ApexCharts(
        most_sold_products,
        options
      );
      most_sold_products_chart.render();
    });
  },
};

export default MostSoldProductsChart;
