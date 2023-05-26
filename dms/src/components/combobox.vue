<template>
    <div class="combobox" >
        <input  id="inputCombobox"
                type="text"
                placeholder="5 Line"
                v-model="folders.name"
                :placeholder="format(pageSize)"
        />
        <div class="btnShowForm " @click="togglePosisons()" :class="{'btnTransform': isDropdownOpen  }">
            <img id="paging-dropdown" src="@/assets/img/dropbottom.svg" alt="" >
        </div>
        <div class="StyleCombobox" v-if="isShowPosion">
            <ul class="listPosison" >
                <li class="listItem"
                    v-for="folders in listLines"
                    :key="folders.id"
                    :class="{ activeBGC: activeClick === folders.id }"
                    @click="selectItem(folders)">

                    {{ folders.name }}
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
export default {
    name: "combobox-paging",
    props: {
        value: {
            type: Number,
            required: true
        }
    },
    data() {
        return {
            isShowPosion: false,
            folders: {},
            activeClick: null,
            isDropdownOpen: false,
            pageSize: 5,
            listLines: [
                {
                    id: 5,
                    name: '5 Lines'
                },
                {
                    id: 10,
                    name: '10 Lines'
                },
                {
                    id: 15,
                    name: '15 Lines'
                },
                {
                    id: 20,
                    name: '20 Lines'
                },
            ]
        };
    },
    watch: {
        value(newPageSize) {
            this.pageSize = newPageSize;
            this.current_page = 1;
        }
    },
    methods: {
        togglePosisons() {
            this.isShowPosion = !this.isShowPosion;
            this.isDropdownOpen = !this.isDropdownOpen;
        },
        selectItem(folder) {
            this.folders = {...folder};
            this.pageSize = folder.id;
            this.folders.name = folder.name;
            this.$emit("update:modelValue", folder.id);
            this.current_page = 1;
            this.updateValue();
            this.isShowPosion = false;
            this.isDropdownOpen = false;

        },
        format(id) {
            switch (id) {
                case 5:
                    return "5 Lines";
                case 10:
                    return "10 Lines";
                case 15:
                    return "15 Lines";
                case 20:
                    return "20 Lines";
            }
        },
        updateValue() {
            this.$emit('input', this.pageSize);
        },

    },
}
</script>
<style lang="scss" scoped>
@import "@/assets/style/_theme.scss";
@import "@/assets/style/_reset.scss";
* {
    margin: 0;
    padding: 0;
    font-family: var(--font);
}

body {
    margin: 0;
    padding: 0;
    font-weight: 400;
    font-family: var(--font);
    pointer-events: none;
}
.activeBGC {
    background-color: var(--bgc-active-menu);
}
.btnTransform img {
    transition: all 0.5s ease-in-out;
    transform: rotate(180deg);
}
label {
  display: block;
}
.combobox {
    display: flex;
    align-items: center;
}
.btnShowForm {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
}
#inputCombobox {
  outline: none;
  padding: 0 10px;
    color: var(--text-color-txt);
    font-weight: 500;
    font-size: 14px;
    max-width: 95px;
    width: 100%;
    pointer-events: none;
    &::placeholder {
        font-weight: 500;
        font-size: 14px;
        pointer-events: none;
        color: var(--text-color-txt);
    }
}
.listItem {
  font-family: sans-serif;
  color: var(--text-color-title);
  font-weight: 600;
  font-size: 14px;
  line-height: 24px;
  min-width: 120px;
  width: 100%;
    border-radius: 8px;
    padding: 8px;
    &:hover {
        background-color: var(--border-color);
    }
}

ul {
  list-style: none;
  width: 100%;
  z-index: 1;
  li {
      width: 100%;
    z-index: 1;
  }
}
.StyleCombobox .listPosison {
  list-style: none;
  width: 100%;

  z-index: 1;
}
.combobox {
    position: relative;
}
.StyleCombobox {
    padding: 16px;
  border: 1px solid var(--border-color);
  cursor: pointer;
  z-index: 1;
    position: absolute;
    top: 50px;
    right: -10px;
  background: var(--background);
  box-shadow: 0 40px 64px -12px rgba(0, 0, 0, 0.08), 0px 0px 14px -4px rgba(0, 0, 0, 0.05), 0px 32px 48px -8px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(16px);
  border-radius: 16px;

}

</style>