<template>
    <div class="topnav d-flex justify-content-between">
        <div class="mr-auto p-2">
          <button @click="openNav">
            <span class="material-icons menu-button">menu</span>
          </button>
        </div>
        <div class="right mr-4">
            <span class="mr-2">
              <button @click="readOneTime" class="icon-badge-container" id="notificationDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <span class="material-icons icon-badge-icon"> notifications </span>
                <div v-if="showIconBadge" class="icon-badge mt-1 font-weight-bold"></div>
              </button>
              <div class="dropdown-menu dropdown-menu-right dropdown-notification" aria-labelledby="notificationDropdown">
                <Notifications/>
              </div>
            </span>
            <span class="ml-2">
              <button id="profileDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <span class="material-icons">account_circle</span>
              </button>
              <div class="dropdown-menu " aria-labelledby="profileDropdown">
                <a class="dropdown-item" href="#">{{$store.state.auth.user.name}}</a>
                <a class="dropdown-item" type="button" @click="$store.dispatch('auth/logout')">Logout</a>
              </div>
          </span>
        </div> 
        
        <div id="mySidebar" class="sidebar">
          <a href="javascript:void(0)" class="closebtn" @click="closeNav">&times;</a>
          <a v-if="$store.state.auth.role==='admin'" href="/admin">Admin</a>
          <a href="/">Home</a>
          <a href="/my-folder">My Folder</a>
          <a href="/shared-with-me">Shared With Me</a>
          <a class="text-secondary" type="button" @click="$store.dispatch('auth/logout')">
				    Logout
          </a>
        </div>
    </div>
</template>
<script setup>

</script>
<script>
  import socket from '../../helpers/socket'
  import Notifications from '../Notifications.vue'
  
  export default {
    components: {Notifications},
    created() {
      if(this.authState.user._id) {
          socket.auth = {userId: this.authState.user._id}
          socket.connect();
      }
      socket.on("new notification", (data) => {
          this.$store.dispatch("user/setNotification", data)
      });
    },
    data() {
      return {
        showIconBadge: false
      }
    },
    methods: {
      readOneTime() {
        this.showIconBadge = false
      },
      openNav() {
        this.$emit("openNav")
      },
      closeNav() {
        this.$emit("closeNav")
      },
    },
    computed:{
        userState() {
            return this.$store.state.user;
        },
        authState() {
            return this.$store.state.auth;
        },
    },
    watch: {
        '$store.state.user.notifications': {
            handler(newVal, oldVal) {
                if(newVal !== oldVal) {
                    this.showIconBadge = newVal.some(e => e.new) ? true : false
                }
            },
            immediate: true,
            deep: true
        },
    },
  }
</script>
<style lang="scss" scoped>
.topnav {
  background-color: rgb(255, 255, 255);
  overflow: hidden;
  height: 6rem;
}
.material-icons {
    font-size: 3rem;
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
  grid-column-start: 30;
  grid-column-end: 31;
}
.grid-item-3 {
  grid-column-start: 32;
  grid-column-end: 33;
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
.icon-badge-container {
    position:relative;
}

.icon-badge-icon {
    position: relative;
    border-radius: 50%;
    padding: 5px;
}
.icon-badge {
  margin-left: 0.7rem;
    background-color: red;
    font-size: 0.9rem;
    color: white;
    text-align: center;
    width:1.2rem;
    height:1.2rem;
    border-radius: 50%;
    position: absolute; /* changed */
    top: -5px; /* changed */
    left: 19px; /* changed */
}
.right {
  position: absolute;
  right: 0px;
  padding: 2rem;
}
.dropdown-notification {
  width: 25rem;
  max-height: 40vh;
  overflow-y: scroll; /* Add the ability to scroll */
}
/* Hide scrollbar for Chrome, Safari and Opera */
.dropdown-notification::-webkit-scrollbar {
    display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
.dropdown-notification {
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
}
</style>