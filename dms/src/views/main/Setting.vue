<template>
    <div class="setting" >
        <div class="setting-last">
            <div
                v-for="(setting, index) in settings"
                :key="index"
                class="setting-last-item"
                :class="{ activebgc: setting.active }"
                @click="selectSetting(index)"
            >
                <img :src="setting.img" alt="error-setting">
                <div class="item-setting--txt" :class="{ activebgc: setting.active }" >{{ setting.text }}</div>
            </div>
        </div>
        <div ref="settingLast" class="setting-firl" >

            <div  class="setting-firl--head" :class="{ activeTabs: activeIndex === 0 }" >
                <div class="head-setting--langg">
                    <div class="lang-title">General</div>
                    <div class="lang-txt">
                        <div class="lang-txt--name">Language</div>

                        <div class="lang-txt--dropdown">
                            <div class="lang-icon" @click="btnClickShowLang()">
                                <img :src="currentLanguage.icon" alt="language-icon" >
                                <input
                                    id="dropdownLang"
                                    :placeholder="currentLanguage.name"
                                    disabled
                                >
                                <img
                                    id="dropdown--lang"
                                    :class="{'btnTransform': activeLang }"
                                    src="@/assets/img/arrow_bottom.svg"
                                    alt="dropdown-icon"
                                >
                            </div>
                            <ul v-show="activeLang" class="lang-options">
                                <li
                                    v-for="(language, index) in languages"
                                    :key="index"
                                    class="lang-item"
                                    :class="{ BGCLangItem: language.active}"
                                    @click="changeLanguage(language)"
                                >
                                    <div v-if="language.CheckLang" class="lang-item--icon"><img v-show="language.active" id="checkLang" :class="{ 'checkLang-icon': language.active }" :src="language.check" alt="language-icon"> </div>
                                    <div class="checkLangg">
                                        <div class="lang-item--icon langIcon"><img :src="language.icon" alt="language-icon"> </div>
                                        <div class="lang-item--txt ">{{ language.name }}</div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div  class="notificationn" :class="{ activeTabs: activeIndex === 1 }" >
                <div class="check-notice">
                    <div class="lang-title">Notifications</div>
                    <div class="lang-txt">
                        <div class="lang-txt--notifice">
                            <img src="@/assets/img/notification_active.svg" alt="">
                            <div class="lang-txt--Noti"> Notifications </div>
                        </div>
                        <div class="lang-txt--check">
                            <div class="roller-checkbox">
                                <label class="checkbox-label" for="checkNotiOn" :class="{ 'checked': isChecked }" @click="isChecked = !isChecked">
                                    <span class="checkbox-text">{{ isChecked ? 'On' : 'Off' }}</span>
                                    <div class="checkbox-roller"></div>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="check-notice--txt">
                    <div class="notice--txt" >Get your important notifications from documents, comments,... </div>
                    <div v-if="isChecked" class="notice--check" :class="{ 'animated': isChecked }">
                        <input id="checkNoti" type="checkbox" :checked="isChecked">
                        <label for="checkNoti">Allow notifications to play sounds</label>
                    </div>
                    <div v-if="isChecked" class="notice--check" :class="{ 'animated': isChecked }">
                        <input id="checkNoti2" type="checkbox" :checked="isChecked">
                        <label for="checkNoti2">Show notifications on the lock screen</label>
                    </div>
                </div>

                <div class="check-notice--txt ">
                    <div class="lang-txt">
                        <div class="lang-txt--notifice">
                            <img src="@/assets/img/pushNoti.svg" alt="">
                            <div class="lang-txt--Noti"> Push Notifications </div>
                        </div>
                        <div class="lang-txt--check">
                            <div class="roller-checkbox">
                                <label class="checkbox-label" :class="{ 'checked': isCheckede }" @click="isCheckede = !isCheckede">
                                    <span class="checkbox-text">{{ isCheckede ? 'On' : 'Off' }}</span>
                                    <div class="checkbox-roller"></div>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="notice--txt">Display new important notifications in the screen.</div>
                </div>

                <div class="check-notice">
                    <div class="lang-txt">
                        <div class="lang-txt--notifice">
                            <img src="@/assets/img/notiFeed.svg" alt="">
                            <div class="lang-txt--Noti"> Notifications Feed </div>
                        </div>
                        <div class="lang-txt--check">
                            <div class="roller-checkbox">
                                <label class="checkbox-label" :class="{ 'checked': isCheckeds }" @click="isCheckeds = !isCheckeds">
                                    <span class="checkbox-text">{{ isCheckeds ? 'On' : 'Off' }}</span>
                                    <div class="checkbox-roller"></div>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="notice--txt notice--feed" >Choose to get different types of notifications.</div>

                </div>
                <div class="check-notice--txt">
                    <div v-if="isCheckeds" class="notice--check opacityNotice" :class="{ 'animated': isCheckeds }">
                        <input id="checkNoti" type="checkbox" :checked="isCheckeds">
                        <label for="checkNoti">Notifications from your documents.</label>
                    </div>
                    <div v-if="isCheckeds" class="notice--check opacityNotice" :class="{ 'animated': isCheckeds }">
                        <input id="checkNoti2" type="checkbox" :checked="isCheckeds">
                        <label for="checkNoti2">Notifications from documents that you need to sign.</label>
                    </div>
                    <div v-if="isCheckeds" class="notice--check" :class="{ 'animated': isCheckeds }">
                        <input id="checkNoti3" type="checkbox" :checked="isCheckeds">
                        <label for="checkNoti3">Notifications from your comments or when someone mentions you in a comment.</label>
                    </div>
                    <div v-if="isCheckeds" class="notice--check" :class="{ 'animated': isCheckeds }">
                        <input id="checkNoti4" type="checkbox" :checked="isCheckeds">
                        <label for="checkNoti4">Notifications from other’s approved documents.</label>
                    </div>
                    <div v-if="isCheckeds" class="notice--check" :class="{ 'animated': isCheckeds }">
                        <input id="checkNoti5" type="checkbox" :checked="isCheckeds">
                        <label for="checkNoti5">Notifications from other’s rejected documents.</label>
                    </div>
                    <div v-if="isCheckeds" class="notice--check" :class="{ 'animated': isCheckeds }">
                        <input id="checkNoti6" type="checkbox" :checked="isCheckeds">
                        <label for="checkNoti6">Notifications from other’s documents you signed.</label>
                    </div>
                    <div v-if="isCheckeds" class="notice--check" :class="{ 'animated': isCheckeds }">
                        <input id="checkNoti7" type="checkbox" :checked="isCheckeds">
                        <label for="checkNoti7">System notifications</label>
                    </div>
                </div>

                <div class="check-notice">
                    <div class="lang-txt">
                        <div class="lang-txt--notifice">
                            <img src="@/assets/img/notiFeed.svg" alt="">
                            <div class="lang-txt--Noti"> Email Notifications </div>
                        </div>
                        <div class="lang-txt--check">
                            <div class="roller-checkbox">
                                <label class="checkbox-label" :class="{ 'checked': isCheckEmail }" @click="isCheckEmail = !isCheckEmail">
                                    <span class="checkbox-text">{{ isCheckEmail ? 'On' : 'Off' }}</span>
                                    <div class="checkbox-roller"></div>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="notice--txt notice--feed" >Display new important notifications in the screen.</div>
                </div>
                <div class="check-notice--txt">
                    <div v-if="isCheckEmail" class="notice--check" :class="{ 'animated': isCheckEmail }">
                        <input id="checkNoti" type="checkbox" :checked="isCheckEmail">
                        <label for="checkNoti">Notifications from your documents.</label>
                    </div>
                    <div v-if="isCheckEmail" class="notice--check" :class="{ 'animated': isCheckEmail }">
                        <input id="checkNoti2" type="checkbox" :checked="isCheckEmail">
                        <label for="checkNoti2">Notifications from documents that you need to sign.</label>
                    </div>
                    <div v-if="isCheckEmail" class="notice--check" :class="{ 'animated': isCheckEmail }">
                        <input id="checkNoti3" type="checkbox" :checked="isCheckEmail">
                        <label for="checkNoti3">Notifications from your comments or when someone mentions you in a comment.</label>
                    </div>
                    <div v-if="isCheckEmail" class="notice--check" :class="{ 'animated': isCheckEmail }">
                        <input id="checkNoti4" type="checkbox" :checked="isCheckEmail">
                        <label for="checkNoti4">Notifications from other’s approved documents.</label>
                    </div>
                    <div v-if="isCheckEmail" class="notice--check" :class="{ 'animated': isCheckEmail }">
                        <input id="checkNoti5" type="checkbox" :checked="isCheckEmail">
                        <label for="checkNoti5">Notifications from other’s rejected documents.</label>
                    </div>
                    <div v-if="isCheckeds" class="notice--check" :class="{ 'animated': isCheckEmail }">
                        <input id="checkNoti6" type="checkbox" :checked="isCheckEmail">
                        <label for="checkNoti6">Notifications from other’s documents you signed.</label>
                    </div>
                    <div v-if="isCheckEmail" class="notice--check" :class="{ 'animated': isCheckEmail }">
                        <input id="checkNoti7" type="checkbox" :checked="isCheckEmail">
                        <label for="checkNoti7">System notifications</label>
                    </div>
                </div>

            </div>
            <div  class="security" :class="{ activeTabs: activeIndex === 2 }" >
                <div class="lang-title">Security</div>
                <div class="lang-password">
                    <div class="lang-password--item">
                        <div class="password-item">
                            <div class="password-icon">
                                <img src="@/assets/img/key.svg" alt="error">
                                <div class="password-txt">Password</div>
                            </div>
                            <div class="passDate">Last updated May 17th, 2023 at 03:15 PM</div>
                        </div>
                        <div class="btn">
                            <div class="btn-password">Change</div>
                        </div>
                    </div>
                </div>
                <div class="lang-password">
                    <div class="lang-password--item">
                        <div class="password-item">
                            <div class="password-icon">
                                <img src="@/assets/img/key.svg" alt="error">
                                <div class="password-txt">Recovery Email Address</div>
                            </div>
                            <div class="passDate">th*****@gr***.vn</div>
                        </div>
                        <div class="btn">
                            <img id="arrorr-btn" src="@/assets/img/arrow_right.svg" alt="error">
                        </div>
                    </div>
                </div>
                <div class="lang-password">
                    <div class="lang-password--item">
                        <div class="password-item">
                            <div class="password-icon">
                                <img src="@/assets/img/key.svg" alt="error">
                                <div class="password-txt">Recovery Email Address</div>
                            </div>
                            <div class="passDate">th*****@gr***.vn</div>
                        </div>
                        <div class="btn">
                            <img id="arrorr-btn" src="@/assets/img/arrow_right.svg" alt="error">
                        </div>
                    </div>
                </div>
                <div class="lang-password">
                    <div class="lang-password--item" @click="btnClickHistory()">
                        <div class="password-item">
                            <div class="password-icon">
                                <img src="@/assets/img/Recent.svg" alt="error">
                                <div class="password-txt">Access History</div>
                            </div>
                            <div class="passDate">View all access histories.</div>
                        </div>
                        <div class="btn">
                            <img id="arrorr-btn"  src="@/assets/img/arrow_right.svg" alt="error" >
                        </div>
                    </div>
                </div>
                <div class="lang-password">
                    <div class="lang-password--item" @click="btnClickSession()">
                        <div class="password-item">
                            <div class="password-icon">
                                <img src="@/assets/img/lang-activeSe.svg" alt="error">
                                <div class="password-txt">Active Sessions</div>
                            </div>
                            <div class="passDate">View and log out of active sessions</div>
                        </div>
                        <div class="btn">
                            <img id="arrorr-btn" src="@/assets/img/arrow_right.svg" alt="error">
                        </div>
                    </div>
                </div>
            </div>
            <div  class="security" :class="{ activeTabs: activeIndex === 3 }" >
                <div class="lang-title">Appearance</div>
                <div class="lang-password listTheme">
                    <div class="lang-password--item" @click="btnShowTheme()">
                        <div class="password-item">
                            <div class="password-icon">
                                <img src="@/assets/img/setting-theme.svg" alt="error">
                                <div class="password-txt">Theme</div>
                            </div>
                            <div class="passDate">Open to manage your theme. </div>
                        </div>
                        <div class="btn" :class="{'btnTransform': isShowTheme }">
                            <img id="arrorr-btn" src="@/assets/img/arrow_bottom.svg" alt="error">
                        </div>
                    </div>
                    <ul v-if="isShowTheme" :class="{ 'animated': isShowTheme }" class="itemTheme">
                        <li class="itemtheme--basic">
                            <div class="Basic-title">Basic</div>
                            <div class="list-item--light">
                                <div class="item-theme--advan">
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/basicLight.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="lightRadio" v-model="selectedTheme" type="radio" value="light">
                                                <label for="lightRadio">System (White Theme)</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/basicDark.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="DarkRadio" v-model="selectedTheme" type="radio" value="dark">
                                                <label for="DarkRadio">System (Dark Theme)</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>

                        <li class="itemtheme--dark">
                            <div class="Basic-title">Advanced</div>
                            <div class="list-item--light">
                                <div class="item-theme--advan">
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/basicDark.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="basicRadio" type="radio">
                                                <label for="basicRadio">System (Dark Theme)</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/basicDark.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="basicRadio" type="radio">
                                                <label for="basicRadio">System (Dark Theme)</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/basicLight.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="basicRadio" type="radio">
                                                <label for="basicRadio">System (White Theme)</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/basicLight.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="basicRadio" type="radio">
                                                <label for="basicRadio">System (White Theme)</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </li>

                    </ul>
                </div>
                <div class="lang-password">
                    <div class="lang-password--item" @click="btnShowBGC()">
                        <div class="password-item">
                            <div class="password-icon">
                                <img src="@/assets/img/setting-bgc.svg" alt="error">
                                <div class="password-txt">Background</div>
                            </div>
                            <div class="passDate">Change your background here.</div>
                        </div>
                        <div class="btn" :class="{'btnTransform': isShowBGC }">
                            <img id="arrorr-btn" src="@/assets/img/arrow_bottom.svg" alt="error">
                        </div>
                    </div>

                    <div v-if="isShowBGC" :class="{ 'animated': isShowBGC }" class="itemTheme">
                        <div class="itemtheme--dark">
                            <div class="Basic-title">Choose one background image</div>
                            <div class="list-item--light">
                                <div class="item-theme--advan">
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/bgcNone.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="bgcNone" v-model="selectedBGC" type="radio" value="none">
                                                <label for="bgcNone">None</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/bgc1.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="bgc1" v-model="selectedBGC" type="radio" value="BG1">
                                                <label for="bgc1">BG 1</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/basicLight.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="bgc2" v-model="selectedBGC" type="radio" value="BG2">
                                                <label for="bgc2">BG 2</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="itemTheme-Basic">
                                        <div class="basic-type">
                                            <img id="theme" src="@/assets/img/basicLight.png" alt="error-basicType">
                                            <div class="basic-type-txt">
                                                <input id="bgc3" v-model="selectedBGC" type="radio" value="BG3">
                                                <label for="bgc3">BG 3</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="lang-password">
                    <div class="lang-password--item">
                        <div class="password-item">
                            <div class="password-icon">
                                <img src="@/assets/img/setting-timer.svg" alt="error">
                                <div class="password-txt">Datetime</div>
                            </div>
                            <div class="passDate">Hanoi, May 17th, 2023 15:15.</div>
                        </div>
                        <div class="btn" :class="{'btnTransform': isShowTheme }">
                            <img id="arrorr-btn" src="@/assets/img/arrow_bottom.svg" alt="error">
                        </div>
                    </div>
                </div>
                <div class="lang-password">
                    <div class="lang-password--item">
                        <div class="password-item">
                            <div class="password-icon">
                                <img src="@/assets/img/setting-volume.svg" alt="error">
                                <div class="password-txt">Sounds</div>
                            </div>
                            <div class="passDate">Change the sounds of the system.</div>
                        </div>
                        <div class="btn" :class="{'btnTransform': isShowTheme }">
                            <img id="arrorr-btn" src="@/assets/img/arrow_bottom.svg" alt="error">
                        </div>
                    </div>
                </div>
            </div>
            <div class="billing" :class="{ activeTabs: activeIndex === 4 }" >
                <div class="billing-title">Billing</div>
                <div class="billing-con">
                    <img src="@/assets/img/billing.svg" alt="error">
                </div>
            </div>
            <div class="billing" :class="{ activeTabs: activeIndex === 5 }" >
                <div class="billing-title">About us</div>
                <div class="billing-con">
                    <img src="@/assets/img/billing.svg" alt="error">
                </div>
            </div>
        </div>
        <div v-if="isShowHistory">
            <modal-history @CloseHistory="isHistory"/>
        </div>
        <div v-if="isSession">
            <modal-active-sess @CloseSession="isAcitiveSession"/>
        </div>
    </div>


</template>
<script>
import modalHistory from '@/components/modalHistory/ModalHistory.vue'
import modalActiveSess from "@/components/modalHistory/ModalActiveSess.vue";
export default {
    components:{
        modalHistory,
        modalActiveSess
    },
    data() {
        return {
            isChecked: false,
            isCheckede: false,
            isCheckeds: false,
            isCheckEmail:false,
            isShowTheme:false,
            isShowBGC:false,
            selectedTheme: 'light',
            selectedBGC:null,
            active:null,
            activeLang:false,
            isSession:false,
            currentLanguage: null,
            activeIndex: null,
            isShowHistory:false,
            settings: [
                { img:require("@/assets/img/Settingsss.svg"), text: "General", active: false },
                { img:require("@/assets/img/notification_active.svg"), text: "General", active: false },
                { img:require("@/assets/img/setting-security.svg"), text: "Security", active: false },
                { img:require("@/assets/img/setting-appearance.svg"), text: "Appearance", active: false },
                { img:require("@/assets/img/setting-billing.svg"), text: "Billing", active: false },
                { img:require("@/assets/img/Detail.svg"), text: "About us", active: false }
            ],
            languages: [
                { code: 'en',check:require("@/assets/img/sucss.svg"), name: 'English', icon: require("@/assets/img/langEN.svg"),CheckLang:true },
                { code: 'fr',check:require("@/assets/img/sucss.svg"),name: 'Vietnamese', icon: require("@/assets/img/langVN.svg"),CheckLang:true },
            ],

        }
    },
    watch: {
        // btn chuyển màu nền theo dạng light và dark
        selectedTheme(newTheme) {
            if (newTheme === 'light') {
                document.documentElement.classList.toggle('dark', false);
                document.documentElement.classList.toggle('light', true);
            } else if (newTheme === 'dark') {
                document.documentElement.classList.toggle('light', false);
                document.documentElement.classList.toggle('dark', true);
            }
        },
        // btn chuyển đổi ảnh nền
        selectedBGC(value) {
            if (value === 'none') {
                document.body.style.backgroundImage = 'none';
            } else if (value === 'BG1') {
                document.body.style.backgroundImage = 'url(@/assets/img/bgc1.png)';
            } else if (value === 'BG2') {
                document.body.style.backgroundImage = 'url(@/assets/img/bgc2.png)';
            } else if (value === 'BG3') {
                document.body.style.backgroundImage = 'url(@/assets/img/bgc3.png)';
            }
        }
    },
    created() {
        this.currentLanguage = this.languages[0];
    },
    methods: {
        btnShowBGC() {
            this.isShowBGC = !this.isShowBGC
        },
        btnShowTheme() {
            this.isShowTheme = !this.isShowTheme
        },
        isAcitiveSession(isSession) {
            this.isSession = isSession
        },
        isHistory(isShowHistory) {
            this.isShowHistory = isShowHistory
        },
        btnClickSession() {
            this.isAcitiveSession(true)
        },
        // showHistory
        btnClickHistory() {
            this.isHistory(true)
        },
        btnClickShowLang() {
            this.activeLang = !this.activeLang;
        },
        // btn thay đổi ngôn ngữ
        changeLanguage(language) {
            this.languages.forEach((lang) => {
                lang.active = false;
            });
            language.active = true;
            this.currentLanguage = language;
            this.activeLang = !this.activeLang;
        },
        // btn đánh index từng item trong menu của setting
        selectSetting(index) {
            this.settings.forEach((setting, i) => {
                setting.active = i === index;
            });

            this.activeIndex = index;
            const settingLast = this.$refs.settingLast;
            if (settingLast && settingLast.children[index]) {
                settingLast.children[index].scrollIntoView({
                    top: 0,
                    behavior: 'smooth'
                });
            }
        }
    },
}
</script>

<style lang="scss" scoped>
@import "@/assets/style/_reset.scss";
@import "@/assets/style/_global.scss";

.setting {
  padding: 16px;
  background: var(--bgc-item--folder);
  display: flex;
  align-items: flex-start;
  gap:0 16px ;
  width: 100%;
  &-last {
    padding: 16px;
    background: var(--backgroud);
    border: 1px solid var(--border-color);
    border-radius: 16px;
    max-width: 280px;
    width: 100%;
    &-item {
      display: flex;
      align-items: center;
      gap:0 16px ;
      padding: 16px;
      cursor: pointer;
    }
  }
  &-firl {
    background: var(--bgc-item--folder);
    border: 1px solid var(--border-color);
    border-radius: 16px;
    width: 100%;
    overflow-y: auto;
    height: calc(100vh - 120px);

    &--head {
      border-radius: 16px 16px 0 0;
      padding: 24px;
      border-bottom: 1px solid var(--border-color);
    }
  }
}
label {
    cursor: pointer;
}
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background-color: var(--bgc-item--folder);
}

::-webkit-scrollbar-thumb {
  background-color: var(--border-color);
  border-radius: 30px;
}


.lang-title {
  font-weight: 600;
  font-size: 24px;
  color: var(--text-color-active);
}
.lang-txt {
  display: flex;
  align-items: center;
  justify-content: space-between;
  &--name {
    font-weight: 600;
    font-size: 16px;
    color: var(--text-color--1);
  }
  &--dropdown {
    max-width: 180px;
    width: 100%;
    position: relative;
    background: var(--backgroud);
    border: 1px solid var(--border-color);
    border-radius: 12px;
    padding: 0 8px;
  }
}
.lang-icon {
  display: flex;
  align-items: center;
  gap: 0 12px;
  cursor: pointer;
}
#dropdownLang {
  width: 100%;
  height: 40px;
  font-weight: 600;
  font-size: 14px;
  color: var(--text-color--1);
  background: var(--backgroud);
  &::placeholder {
    font-weight: 600;
    font-size: 14px;
    color: var(--text-color--1);
  }
}
#dropdown--lang {
  cursor: pointer;
}

.notificationn {
  padding: 24px 24px 40px 24px;
  border-bottom: 1px solid var(--border-color);
}

.lang-txt {
  margin: 16px 0;
  &--notifice {
    display: flex;
    align-items: center;
    gap:0 8px;
  }
  &--Noti {
    font-weight: 600;
    font-size: 16px;
    color: var(--text-color--1);
  }
  &--check {
    display: flex;
    flex-direction: inherit;
    align-items: center;
  }
}

.roller-checkbox {
  display: flex;
  align-items: center;
}

.checkbox-label {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 30px;
  height: 14px;
  cursor: pointer;
  border-radius: 15px;
  background-color: #e0e0e0;
  transition: background-color ease-in-out 0.2s;
}

.checkbox-label.checked .checkbox-roller {
  transform: translateX(15px);
}

.checkbox-label.checked {
  background-color: var(--text-color-active);
}

.checkbox-label.checkede .checkbox-roller {
  transform: translateX(15px);
}

.checkbox-text {
  position: absolute;
  font-size: 14px;
  top: -5px;
  left: -30px;
  font-weight: 500;
  color: var(--text-color--1);
}

.checkbox-roller {
  position: absolute;
  top: 1px;
  left: 1px;
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background-color: var(--background);
  transition: transform ease-in-out 0.2s;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.2);
}
#arrorr-btn {
  width: 15px;
  height: 15px;
}
.check-notice--txt {
  border-bottom: 1px solid var(--border-color);
}
.notice--txt {
  font-weight: 600;
  font-size: 12px;
  color: var(--text-color-txt);
  margin: 0 0 16px 32px;

}
.notice--check {
  margin: 0 0 16px 32px;
  display: flex;
  align-items: center;
  gap: 0 8px;
}

.check-notice--txt:last-child {
  border: none;
}
.security {
  padding: 24px 24px 40px 24px;
  border-bottom: 1px solid var(--border-color);
}

.lang-password {
  padding: 16px 0;
  border-bottom: 1px solid var(--border-color);
  &--item {
    display: flex;
    justify-content: space-between;
    cursor: pointer;
  }
}
.lang-password:last-child {
  border: none;
  padding: 16px 0 0 0;
}
.password-icon {
  display: flex;
  align-items: center;
  gap:  0 8px;
}
.passDate {
  margin: 8px 0 0 28px;
  font-weight: 600;
  font-size: 12px;
  color: var(--text-color-txt);
}
.password-txt {
  font-weight: 600;
  font-size: 16px;
  color: var(--text-color--1);
}
.btn-password {
  padding: 8px 34px;
  font-weight: 500;
  font-size: 14px;
  color: var(--text-color--1);
  background: var(--bgc-folder--icon);
  border: 1px solid var(--border-color);
  border-radius: 8px;
}
.billing {
  padding:24px ;
  border-bottom: 1px solid var(--border-color);
  &-title {
    font-weight: 600;
    font-size: 24px;
    color: var(--text-color-active);

  }
  &-title:last-child {
  }
  &-con {
    display: flex;
    align-items: center;
    justify-content: center;
  }
}
.item-setting--txt {
  font-weight: 600;
  font-size: 14px;
  color: var(--text-color--1);
}
.activebgc {
  background-color: var(--bgc-active-menu);
  border-radius: 8px;
  color:var(--text-color-active);
  z-index: 1;
  position: relative;
}

.activebgc:before {
  content: "";
  position: absolute;
  right: -16px;
  top: 10px;
  bottom: 0;
  width: 4px;
  background-color: transparent;
  transition: background-color 0.3s;
}
.activebgc:before {
  width: 4px;
  height: 35px;
  border-radius: 4px;
  background-color: var(--text-color-active);
}
.item-setting--txt.activebgc:before {
  background-color: transparent;
}
.setting-last-item img {
  width: 20px ;
}

.activeTabs {
  position: relative;
  background-color: var(--backgroud);
  border-radius: 4px;
}

.activeTabs:before {
  content: '';
  position: absolute;
  left: 0;
  top: 25px;
  bottom: 0;
  width: 4px;
  background-color: transparent;
  transition: background-color 0.3s;
}
.activeTabs:before {
  width: 4px;
  height: 35px;
  border-radius: 4px;
  background-color: var(--text-color-active);
}

.lang-txt--dropdown {
  position: relative;
}

.lang-options {
  min-width: 180px;
  position: absolute;
  top: 45px;
  left: 0;
  list-style: none;
  padding: 16px;
  margin: 0;
  background-color: var(--backgroud);
  box-shadow: 0 40px 64px -12px rgba(0, 0, 0, 0.08), 0px 0px 14px -4px rgba(0, 0, 0, 0.05), 0px 32px 48px -8px rgba(0, 0, 0, 0.1);
  border-radius: 16px;
}

.lang-options li {
  padding: 8px;
  cursor: pointer;
}

.lang-dropdown:hover .lang-options {
  display: block;
}
#checkLang {
  width: 12px;
  height: 8px;
}
.lang-item {
  display: flex;
  align-items: center;
  padding: 8px;
  &--txt {
    font-weight: 600;
    font-size: 14px;
    color: var(--text-color--1);
  }
}
.BGCLangItem {
  background-color: var(--bgc-active-menu);
  border-radius: 12px;
  z-index: 1;
  position: relative;
}
.checkLang-icon {
  visibility: visible;
  position: absolute;
}
.langIcon {
  margin-left: 20px;
}

.checkLangg {
  display: flex;
  align-items: center;
  gap: 0 8px;
}

@keyframes slideDown {
  0% {
    opacity: 0;
    transform: translateY(-15px);
  }
  100% {
    opacity: 1;
    transform: translateY(0);
  }
}

.animated {
  animation: slideDown .5s ease;
}
.opacityNotice {
  opacity: 0.5;
}


.itemTheme {
    margin-top: 16px;
    gap:0 24px;
}
.Basic-title {
    margin-bottom: 4px;
    font-weight: 500;
    font-size: 14px;
    color: var(--text-color-txt);
}
.Basic-title1 {
    visibility: hidden;
}
.itemTheme-Basic {
    display: grid;
    gap: 4px 0;
}
.itemtheme--basic {
    margin-bottom: 16px;
    gap:0 24px;
}
.basic-type-txt{
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 8px 0;
}
.basic-type{
    border: 1px solid var(--border-color);
    border-radius: 8px;
}
.itemtheme--dark {
    gap: 0 24px;
}
#theme {
    width: calc(100% + 1px);
    border-top-left-radius:8px;
    border-top-right-radius:8px ;
}
.item-theme--advan {
    display: flex;
    align-items: center;
    gap:0 24px;
}
// background
.btnTransform {
    transition: all 0.5s ease-in-out;
    transform: rotate(180deg);
}



</style>

