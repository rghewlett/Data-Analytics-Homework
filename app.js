// from data.js
var tableData = data;


// where we will insert the table
var tbody = d3.select("tbody");

//this reads every report
//tableData.forEach(report => console.log(report))

var submit = d3.select("#filter-btn");

submit.on("click", function() {

  // Prevent the page from refreshing
  d3.event.preventDefault();  
  
  // Select the input element and get the raw value
  var inputdate = d3.select("#datetime");

  var inputValue = inputdate.property("value");  

  // QC 

  console.log(inputValue)
   
  var filteredData = tableData.filter(report => report.datetime === inputValue);

  //QC

  console.log(filteredData);

  tableData.forEach((event) => {
    var emptyrow = d3.selectAll('tbody>tr');
    Object.entries(event).forEach(() => {
      var emptycell = d3.selectAll('tbody>td').text('');
    });
  });

  filteredData.forEach(function(report) {
    var row = tbody.append("tr");
    Object.entries(report).forEach(function([key, value]) {
        var cell = tbody.append("td");
        cell.text(value);
      });
    })
})