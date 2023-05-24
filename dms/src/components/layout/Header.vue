<template>
    <div class="topbar-head">
        <div class="topbar">
            <div class="topbar-header">
                <div class="topbar-item">
                    <h1 class="title">{{ documentState.folder.name }}</h1>
                </div>
                <div class="topbar-item search">
                    <div class="search-file">
                        <img id="search-icon" src="@/assets/img/Search.svg" alt="error-search">
                        <input id="search-input" type="text" placeholder="Search everything">
                    </div>
                </div>

                <div class="topbar-item--option">
                    <div class="icon-option">
                        <div class="icon-notife--dowload">
                            <img src="@/assets/img/dowload-detail.svg" alt="error-download">
                        </div>
                        <div class="icon-notife">
                            <button @click="readOneTime" class="icon-badge-container" id="notificationDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="@/assets/img/notification_active.svg" alt="">
                                <div v-if="showIconBadge" class="icon-badge mt-1 font-weight-bold"></div>
                            </button>
                            <div class="dropdown-menu dropdown-menu-right dropdown-notification" aria-labelledby="notificationDropdown">
                                <Notifications/>
                            </div>
                        </div>
                        <div class="user-setting">
                            <img src="@/assets/img/Settings.svg" alt="error-settings">
                        </div>

                        <div class="use-iconOption">
                            <button id="profileDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="@/assets/img/Oval.png" alt="">

                            </button>
                            <div class="dropdown-menu " aria-labelledby="profileDropdown">
                                <a class="dropdown-item" href="#">{{$store.state.auth.user.name}}</a>
                                <a class="dropdown-item" type="button" @click="$store.dispatch('auth/logout')">Logout</a>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
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
        documentState() {return this.$store.state.document },
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
@import "@/assets/style/_theme.scss";
@import "@/assets/style/_reset.scss";
.topbar-head {
    padding: 20px 16px;
    border-bottom: 0.5px solid var(--border-color);
    background-color: var(--backgroud);
    height: 80px;
}
.icon-notife--dowload {
    cursor: pointer;
}
//
topbar {
  &-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 16px;

  }
}
.icon-option{
    display: flex;
    align-items: center;
    gap: 0 40px;
}
.search {
  max-width: 528px;
  width: 100%;
  border: 1px solid var(--border-color);
  border-radius: 200px;
  &-file {
    padding: 12px 26px;
  }
}
#search-icon {
  margin-right:19px ;
  cursor: pointer;
}
#search-input {
    color: var(--text-color--1);
  font-style: normal;
  font-weight: 600;
  font-size: 14px;
  &::placeholder {
      color: var(--text-color-input);
  }
}
.title {
  font-style: normal;
  font-weight: 600;
  font-size: 32px;
  line-height: 40px;
  letter-spacing: 0.02em;
  color: var(--text-color--1);
}
.frame-use {
  display: flex;
  align-items: center;
  gap: 0 40px;
}
.user-setting {
  cursor: pointer;
}
.user-icon {
  cursor: pointer;
}
.user-notice {
  cursor: pointer;
}
.topbar-header {
  position: relative;
  display: flex;
    justify-content: space-between;
    align-items: center;
}
.notification-page {
  position: absolute;
  top: 95px;
  right: 120px;
  z-index: 2;
}
.notification {

  &-modal {
    max-width: 496px;
    width: 100%;
    background: var(--backgroud);
    box-shadow: 0 8px 12px rgba(0, 0, 0, 0.1);
    border-radius: 16px;
    padding: 24px;
    &--head {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 16px;
    }
    &--btn {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding-bottom: 8px;
      border-bottom: 1px solid var(--border-color);
    }
  }

}
.modal-btn {
  display: flex;
  align-items: center;
  gap: 0 24px;

  &--all {
    font-weight: 600;
    font-size: 14px;
    color: var(--text-color-txt);
    padding: 4px;
    width: 80px;
    text-align: center;
    background-color: var(--backgroud);
    border-radius: 10px;
    cursor: pointer;
  }
  &--unread {
    font-weight: 600;
    font-size: 14px;
      color: var(--text-color-txt);
    padding: 4px;
    width: 80px;
    text-align: center;
    background-color: var(--backgroud);
    border-radius: 10px;
    cursor: pointer;
  }
}
.modal-viewAll {
  display: flex;
  align-items: center;
  gap: 0 4px;
  &--txt {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color-active);
    cursor: pointer;
  }
}

.user-item {
  margin-top: 8px;
  padding: 8px 12px 16px 12px;
  border-bottom: 1px solid var(--border-color);
  &:hover {
    background: var(--bgc-active-item);
    border-radius: 12px;
  }
  &--flex {
    display: flex;
    gap: 0 8px;
  }
}
.user-item:last-child {
  border: none;
}

.active {
  background-color: var(--text-color-active);
  color: var(--backgroud);
  transition: all .5s ease-in-out;
}
.notification-modal--list {
  transition: opacity 0.3s ease-in-out;
  opacity: 1;
}
.notification-modal--list.hidden {
  opacity: 0;
}

.notification-modal--list.previous {
  opacity: 0;
  z-index: 0;
}

</style>