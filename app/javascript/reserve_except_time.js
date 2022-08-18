function reserveExceptTime(){
  const flatPickr = document.getElementById("flatpickr");
  if (!flatPickr){ return false;}
  flatPickr.addEventListener("change",()=>{
    const reservationDate = flatPickr.value;
    fetch('/api/reservation_times?reservation_date='+reservationDate)
	  .then(response => response.json())
	  .then(data => {
		  const reservationList = data.response_hash;
      Object.prototype.extendFunc = function(){};
      valueReservationList = Object.values(reservationList);
      const reservationTime = document.getElementById("reservation_reservation_time");
      const reservationPeopleNumber = document.getElementById("reservation_people_number");
      for (let i=0; i<valueReservationList.length; i++){
        reservationTime.children[i+1].style.display = 'block';
        if( valueReservationList[i] == false){
            reservationTime.children[i+1].style.display = 'none';
        };
      };
      if(reservationTime != "" || reservationPeopleNumber != ""){
        reservationTime.children[0].selected = true;
        reservationPeopleNumber.children[0].selected = true;
      };
	  });
  });
};

window.addEventListener('load',reserveExceptTime);