function reserve(){
  const flatPickr = document.getElementById("flatpickr");
  flatPickr.addEventListener("change",()=>{
    const resavationDate = flatPickr.value;
    console.log(resavationDate);
    fetch('/api/resavation_times?resavation_date='+resavationDate)
	  .then(response => response.json())
	  .then(data => {
		console.log(data);
	});
  });
};

window.addEventListener('load',reserve);