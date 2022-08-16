function reserveExceptTime(){
  const flatPickr = document.getElementById("flatpickr");
  if (!flatPickr){ return false;}
  flatPickr.addEventListener("change",()=>{
    const resavationDate = flatPickr.value;
    console.log(resavationDate);
    fetch('/api/resavation_times?resavation_date='+resavationDate)
	  .then(response => response.json())
	  .then(data => {
		  const resavationList = data.response_hash;
      Object.prototype.extendFunc = function(){};
      valueResavationList = Object.values(resavationList);
      const resavationTime = document.getElementById("reserve_resavation_time");
      const resavationPeopleNumber = document.getElementById("reserve_people_number");
      for (let i=0; i<valueResavationList.length; i++){
        resavationTime.children[i+1].style.display = 'block';
        if( valueResavationList[i] == false){
            resavationTime.children[i+1].style.display = 'none';
        };
      };
      if(resavationTime != "" || resavationPeopleNumber != ""){
        resavationTime.children[0].selected = true;
        resavationPeopleNumber.children[0].selected = true;
      };
	  });
  });
};

window.addEventListener('load',reserveExceptTime);