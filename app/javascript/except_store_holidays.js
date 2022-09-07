function exceptStoreHolidays(){
  const flatPickr = document.getElementById("flatpickr");
  if (!flatPickr){ return false;};
  console.log(flatPickr._flatpickr.config.disable['1']);
  // flatPickr.addEventListener("click",()=>{
  flatPickr._flatpickr.config.disable['2'] = new Date(2022, 8, 22);
  console.log(flatPickr._flatpickr.config.disable['2']);
  // });
};

window.addEventListener('load',exceptStoreHolidays);