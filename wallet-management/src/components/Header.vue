<template>
    <div class="topnav grid-container">
        <div class="grid-item-1">
          <button @click="openNav">
            <span class="material-icons menu-button">menu</span>
          </button>
        </div>
        <div class="grid-item-2">
            <button>
                <span class="material-icons"> notifications </span>
            </button>
        </div>
        <div class="grid-item-3">
            <button>
                <span class="material-icons">account_circle</span>
            </button>
        </div> 
        <div id="mySidebar" class="sidebar">
          <a href="javascript:void(0)" class="closebtn" @click="closeNav">&times;</a>
          <a href="/">Home</a>
          <a href="/applications">Applications</a>
        </div>
    </div>
</template>
<script setup>
/* Set the width of the sidebar to 250px and the left margin of the page content to 250px */
function openNav() {
  document.getElementById("mySidebar").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
}

/* Set the width of the sidebar to 0 and the left margin of the page content to 0 */
function closeNav() {
  document.getElementById("mySidebar").style.width = "0";
  document.getElementById("main").style.marginLeft = "0";
}
</script>
<style lang="scss" scoped>
.topnav {
  background-color: rgb(255, 255, 255);
  overflow: hidden;
  height: 4rem;
}
.material-icons {
    font-size: 2.5rem;
    color: var(--primary);
}
.menu-button {
  @media only screen and (min-width: 1100px) {
		display: none;
	}
}
.menu-button:hover {
  background-color: #dedede;
  color: var(--light);
}
.grid-container {
  display: grid;
  grid-template-columns: auto auto auto;
  gap: 10px;
}
.grid-container > div {
  text-align: center;
  margin: auto;
}
.grid-item-1 {
  grid-column-start: 1;
  grid-column-end: 2;
}
.grid-item-2 {
  grid-column-start: 20;
  grid-column-end: 21;
}
.grid-item-3 {
  grid-column-start: 21;
  grid-column-end: 22;
}
/* The sidebar menu */
.sidebar {
  height: 100%; /* 100% Full-height */
  width: 0; /* 0 width - change this with JavaScript */
  position: fixed; /* Stay in place */
  z-index: 1; /* Stay on top */
  top: 0;
  left: 0;
  background-color: #111; /* Black*/
  overflow-x: hidden; /* Disable horizontal scroll */
  padding-top: 60px; /* Place content 60px from the top */
  transition: 0.5s; /* 0.5 second transition effect to slide in the sidebar */
}

/* The sidebar links */
.sidebar a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

/* When you mouse over the navigation links, change their color */
.sidebar a:hover {
  color: #f1f1f1;
}

/* Position and style the close button (top right corner) */
.sidebar .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
@media screen and (max-height: 450px) {
  .sidebar {padding-top: 15px;}
  .sidebar a {font-size: 18px;}
}


</style>