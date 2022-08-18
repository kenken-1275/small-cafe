function reserveExceptPeopleNumber(){
  const reserveTime = document.getElementById("reservation_reservation_time");
  if (!reserveTime){ return false;}
  reserveTime.addEventListener("change",()=>{
    const flatPickr = document.getElementById("flatpickr");
    const reservationDate = flatPickr.value;
    fetch('/api/reservation_people_numbers?reservation_date='+reservationDate)
	  .then(response => response.json())
	  .then(data => {
      const reservationHash = data.response_hash;
      const reservationPeopleNumber = document.getElementById("reservation_people_number");
      const valueReservationTime = reserveTime.value;
      for (let i=0;i<reservationPeopleNumber.children.length;i++){
          reservationPeopleNumber.children[i].style.display = 'block';
      };
      if(reservationHash[valueReservationTime] == 1){
        reservationPeopleNumber.children[3].style.display = 'none';
      }else if(reservationHash[valueReservationTime] == 2){
        for (let i=2;i<4;i++){
          reservationPeopleNumber.children[i].style.display = 'none';
        };
      };
      if(reservationPeopleNumber != ""){
        reservationPeopleNumber.children[0].selected = true;
      };
	  });
  });
};

window.addEventListener('load',reserveExceptPeopleNumber);