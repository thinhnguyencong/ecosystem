<template>
    <div class="modalActive">
        <div class="modalActive-bgc">
            <div class="modal-head">
                <div class="modal-head--title">Access History</div>
                <div class="modal-head--option"><img src="@/assets/img/option-comment.svg" alt="error"></div>
            </div>
            <ul class="modal-content--sion">
                <li
                        v-for="(browser , index) in Browsers"
                        :key="index"
                        class="modal-item-browser">
                    <div class="icon-browser">
                        <div class="icon-browser--head">
                            <img :src="browser.icon" alt="error-icon">
                            <div class="brower-Chrome--title">{{ browser.name }}</div>
                            <div class="logout-icon">
                                <div class="logout-icon-txt">Log out</div>
                                <img src="@/assets/img/logOut.svg" alt="error-logOut">
                            </div>
                        </div>
                        <div class="browers-list">
                            <div class="icon-browser--txt">
                                <div class="browser-txt">{{ browser.lastactivity }}</div>
                                <div class="browser-txt">{{ browser.FirstTime }}</div>
                                <div class="browser-txt">{{ browser.OS }}</div>
                                <div class="browser-txt">{{ browser.Browser }}</div>
                                <div class="browser-txt">{{ browser.SessionID }}</div>
                            </div>
                            <div class="icon-browser--date">
                                <div class="browser--item--txt">May 17 2023, 15:15</div>
                                <div class="browser--item--txt">April 18 2022, 08:00</div>
                                <div class="browser--item--txt">Windows 11</div>
                                <div class="browser--item--txt">Chrome</div>
                                <div class="browser--item--txt">ucff5pa3mibodfd3jfiwjdxikr</div>
                            </div>
                        </div>

                    </div>
                </li>
            </ul>
            <div class="closeHistory" >
                <button class="btnClose" @click="btnClose()">Close</button>
            </div>
        </div>
    </div>
</template>
<script>
export default {
    data() {
        return {
            Browsers : [
                {
                    icon:require("@/assets/img/window.svg"),
                    name: 'Chrome',
                    lastactivity: 'lastactivity:',
                    FirstTime:'First time active:',
                    OS:'OS:',
                    Browser:'Browser:',
                    SessionID:'Session ID:'
                },
                {
                    icon:require("@/assets/img/mac.svg"),
                    name: 'Safari:',
                    lastactivity: 'lastactivity:',
                    FirstTime:'First time active:',
                    OS:'OS:',
                    Browser:'Browser:',
                    SessionID:'Session ID:'
                },
                {
                    icon:require("@/assets/img/mac.svg"),
                    name: 'Safari:',
                    lastactivity: 'lastactivity:',
                    FirstTime:'First time active:',
                    OS:'OS:',
                    Browser:'Browser:',
                    SessionID:'Session ID:'
                },
                {
                    icon:require("@/assets/img/mac.svg"),
                    name: 'Safari:',
                    lastactivity: 'lastactivity:',
                    FirstTime:'First time active:',
                    OS:'OS:',
                    Browser:'Browser:',
                    SessionID:'Session ID:'
                },
            ],
            listDetailBrowsers: [
                {

                }
            ]
        }
    },
    mounted() {
        document.addEventListener('keydown', this.keydownEvent);
    },
    destroyed() {
        document.removeEventListener('keydown', this.keydownEvent);
    },
    methods: {
        keydownEvent(event) {
            if (event.key === 'Escape') {
                this.btnClose();
            }
        },
        btnClose() {
            this.$emit("CloseSession", false);
        }
    }
}
</script>
<style lang="scss" scoped>
@import "@/assets/style/_reset.scss";
@import "@/assets/style/_global.scss";

.modalActive {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 1;
  background: rgba(0, 0, 0, 0.6);
  &-bgc {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%,-50%);
    background: #FFFFFF;
    box-shadow: 0 40px 64px -12px rgba(0, 0, 0, 0.08), 0px 0px 14px -4px rgba(0, 0, 0, 0.05), 0px 32px 48px -8px rgba(0, 0, 0, 0.1);
    border-radius: 16px;
    max-width: 620px;
    max-height: 860px;
    width: 100%;
    height: 100%;
  }
}
.modal-head {
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-weight: 600;
  font-size: 20px;
  color: #12131C;
  padding: 24px;
  &--option {
    cursor: pointer;
  }
}
.modal-content--sion {
  padding: 0 24px;
  height: 690px;
  overflow-y: auto;
}
.brower-Chrome--title {
  font-weight: 500;
  font-size: 18px;
  color: #12131C;
}
.browser-txt {
  font-weight: 500;
  font-size: 14px;
  color: #6F7180;
  padding: 8px 0;
}
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background-color: #FAFAFA;
}

::-webkit-scrollbar-thumb {
  background-color: #EDEDED;
  border: 0.5px solid #C1C0C9;
  border-radius: 30px;
}
.browser--item--txt {
  font-weight: 500;
  font-size: 14px;
  color: #32373D;
  padding: 8px 0;
}
.logout-icon-txt{
  font-weight: 500;
  font-size: 14px;
  color: #12131C;
}
.modal-item-browser {
  margin-bottom: 24px;
  background: #F7F7F8;
  border: 1px solid #EDEDED;
  border-radius: 16px;
  padding: 16px;
}
.modal-item-browser:last-child {
  margin: 0;
}
.icon-browser--head {
  position: relative;
  display: flex;
  align-items: center;
  gap: 0 24px;

}
.browers-list {
  display: flex;
  gap: 0 34px;
  margin-left: 50px;
}

.logout-icon {
  position: absolute;
  top: 0;
  right: 0;
  display: flex;
  align-items: center;
  justify-content: end;
  gap: 0 4px;
  padding: 8px;
  background: #FFFFFF;
  border: 1px solid #EDEDED;
  border-radius: 8px;
  cursor: pointer;

}

.closeHistory {
  position: absolute;
  bottom: 24px;
  right: 24px;

}
.btnClose {
  font-weight: 500;
  font-size: 14px;
  color: #12131C;
  padding: 8px 40px;
  background: #F7F7F8;
  border: 1px solid #EDEDED;
  border-radius: 8px;
}
</style>
