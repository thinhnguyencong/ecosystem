<template>
  <div class="modall">
      <div class="modal-icon">
          <router-link to="/" >
              <div class="iconHome">
                  <img id="arrowHome" src="@/assets/img/arrow_right.svg" alt="error-icon">
                  <div class="modal-icon--home">Home</div>
              </div>
          </router-link>
          <div class="modal-icon--list">
              <router-link to="">
                  <div class="modal-item--folder">
                      <img id="arrow-right" src="@/assets/img/arrow_right.svg" alt="error-icon">
                      <div class="modal-item--text">My Folder</div>
                  </div>
              </router-link>
              <router-link to="">
                  <div class="modal-item--folder">
                      <img id="arrow-right" src="@/assets/img/arrow_right.svg" alt="error-icon">
                      <div class="modal-item--text">Share</div>
                  </div>
              </router-link>

              <router-link to="">
                  <div class="modal-item--folder">
                      <img id="arrow-right" src="@/assets/img/arrow_right.svg" alt="error-icon">
                      <div class="modal-item--text">Sign</div>
                  </div>
              </router-link>
              <router-link to="">
                  <div class="modal-item--folder">
                      <img id="arrow-right" src="@/assets/img/arrow_right.svg" alt="error-icon">
                      <div class="modal-item--text">Starred</div>
                  </div>
              </router-link>
              <router-link to="">
                  <div class="modal-item--folder">
                      <img id="arrow-right" src="@/assets/img/arrow_right.svg" alt="error-icon">
                      <div class="modal-item--text">Hidden</div>
                  </div>
              </router-link>
              <router-link to="/recent">
                  <div class="modal-item--folder">
                      <img id="arrowHome" src="@/assets/img/arrow_right.svg" alt="error-icon">
                      <div class="modal-item--text">Recent</div>
                  </div>
              </router-link>
          </div>
      </div>
  </div>
</template>
<script>
    export default {

    }
</script>
<style lang="scss" scoped>
.modall {
    position: absolute;
    width:214px;
    background: var(--backgroud);
    box-shadow: 0 40px 64px -12px rgba(0, 0, 0, 0.08), 0px 0px 14px -4px rgba(0, 0, 0, 0.05), 0px 32px 48px -8px rgba(0, 0, 0, 0.1);
    backdrop-filter: blur(16px);
    border-radius: 12px;
    z-index: 1;
    padding: 16px 8px;
    transition: all .5s ease-in-out;
    .modal-icon {
        display: grid;
        gap: 8px 0;
    }
    .modal-icon--list {
        display: grid;
        gap: 8px 0;
    }
    .iconHome {
        display: flex;
        align-items: center;
        gap: 0 8px;
        #arrowHome {
            visibility: hidden;
        }
    }

    .modal-item--text {
        font-size: 12px;
        color: var(--text-color--2);
    }
    .modal-item--folder {
        display: flex;
        align-items: center;
        gap: 0 8px;
    }
    #arrow-bottom {
        width: 10px;
        height: 6px;
    }
    .modal-icon--home {
        font-size: 12px;
        color: var(--text-color--2);
    }
}
li {
}
a:hover {
   text-decoration: none;
}
</style>