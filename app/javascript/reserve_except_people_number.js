function reserveExceptPeopleNumber(){
  const reserveTime = document.getElementById("reserve_resavation_time");
  if (!reserveTime){ return false;}
  reserveTime.addEventListener("change",()=>{
    const flatPickr = document.getElementById("flatpickr");
    const resavationDate = flatPickr.value;
    console.log(resavationDate);
    fetch('/api/resavation_people_numbers?resavation_date='+resavationDate)
	  .then(response => response.json())
	  .then(data => {
      const resavationHash = data.response_hash;
      const resavationPeopleNumber = document.getElementById("reserve_people_number");
      const valueResavationTime = reserveTime.value;
      for (let i=0;i<resavationPeopleNumber.children.length;i++){
          resavationPeopleNumber.children[i].style.display = 'block';
      };
      if(resavationHash[valueResavationTime] == 1){
        resavationPeopleNumber.children[3].style.display = 'none';
      }else if(resavationHash[valueResavationTime] == 2){
        for (let i=2;i<4;i++){
          resavationPeopleNumber.children[i].style.display = 'none';
        };
      };
      if(resavationPeopleNumber != ""){
        resavationPeopleNumber.children[0].selected = true;
      };
	  });
  });
};

window.addEventListener('load',reserveExceptPeopleNumber);