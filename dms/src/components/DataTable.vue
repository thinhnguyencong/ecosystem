<template>
    <v-data-table
        v-model="selected"
        :headers="headers"
        :items="filteredItems"
        :pagination.sync="pagination"
        select-all
        item-key="name"
        class="elevation-1"
      >
        <template slot="headers" slot-scope="props">
          <tr>
            <th>
              <v-checkbox
                :input-value="props.all"
                :indeterminate="props.indeterminate"
                primary
                hide-details
                @click.native="toggleAll"
              ></v-checkbox>
            </th>
            <th
              v-for="header in props.headers"
              :key="header.text"
              :class="['column sortable', pagination.descending ? 'desc' : 'asc', header.value === pagination.sortBy ? 'active' : '']"
              @click="changeSort(header.value)"
            >
              <v-icon small>arrow_upward</v-icon>
              {{ header.text }}
            </th>
          </tr>
          <tr class="grey lighten-3">
            <th>
              <v-icon>filter_list</v-icon>
            </th>
            <th
              v-for="header in props.headers"
              :key="header.text"
            >
              <div v-if="filters.hasOwnProperty(header.value)">
                <v-select label="Filter..." flat hide-details small multiple clearable :items="columnValueList(header.value)" v-model="filters[header.value]">
                  
                </v-select>
                
              </div>
            </th>
          </tr>
        </template>
        <template slot="items" slot-scope="props">
          <tr :active="props.selected" @click="handleSelectRow">
            <td>
              <v-checkbox
                :input-value="props.selected"
                primary
                hide-details
                @change="props.selected = !props.selected"
              ></v-checkbox>
            </td>
            <td class="truncate" v-for="(attribute, key) in props.item" :key="key">{{attribute}}</td>
            <!-- <td>{{ props.item.name }}</td>
            <td class="text-xs-right">{{ props.item.calories }}</td>
            <td class="text-xs-right">{{ props.item.fat }}</td>
            <td class="text-xs-right">{{ props.item.carbs }}</td>
            <td class="text-xs-right">{{ props.item.protein }}</td>
            <td class="text-xs-right">{{ props.item.iron }}</td> -->
          </tr>
        </template>
        <template v-slot:footer>
          <td :colspan="headers.length" v-if="Object.values(selected).length">
            <strong>{{Object.values(selected).length}} rows selected</strong>
          </td>
          <td :colspan="headers.length" v-else>
            
          </td>
        </template>
    </v-data-table>
</template>

<script>

export default {
    props: {
        headersProps: Array,
        itemsProps: Array
    },
    data: () => ({
        pagination: {
            sortBy: 'name',
            rowsPerPage: 10
        },
        selected: [],
        headers: [],
        filters: {},
        items: [],
    }),
    mounted() {
       this.$set(this, 'headers', this.headersProps)
       this.$set(this, 'filters', this.getFilters(this.headersProps))
       this.$set(this, 'items', this.modifyItems(this.itemsProps, this.headers))
    },
    computed: {
        filteredItems() {
            return this.items.filter(d => {
                return Object.keys(this.filters).every(f => {
                    return this.filters[f].length < 1 || this.filters[f].includes(d[f])
                })
            })
        },
    },

  methods: {
    toggleAll () {
      if (this.selected.length) {
        this.selected = []
        this.$emit('handleSelectRow', this.selected)
      }
      else{
        this.selected = this.items.slice()
        this.$emit('handleSelectRow', this.selected)
      } 
    },
    changeSort (column) {
      if (this.pagination.sortBy === column) {
        this.pagination.descending = !this.pagination.descending
      } else {
        this.pagination.sortBy = column
        this.pagination.descending = false
      }
    },
    columnValueList(val) {
      return this.items.map(d => d[val])
    },
    getFilters(headers) {
        let filters = {}
        const abc = headers.filter(h=> h.filter).map(x=> x.value)
        for(let i=0; i<abc.length; i++){
            filters[abc[i]] = []
        }
        return filters
    },
    handleSelectRow() {
      this.$emit('handleSelectRow', this.selected)
    },
    modifyItems(items, headers) {
      let headersArr = headers.map(x=> x.value)
      let result = [];
      for(let j=0; j< items.length; j++) {
          let obj = {};
          for(let i =0; i< headersArr.length; i++) {
              obj[headersArr[i]] = items[j][headersArr[i]] ?? null
          }
          result.push(obj)
      }
      return result
    }
  },
  watch: { 
    headersProps: {
      handler(newVal, oldVal) { // watch it
        this.headers = newVal
      },
      immediate: true
    },
    itemsProps: {
      handler(newVal, oldVal) { // watch it
        this.items = this.modifyItems(newVal, this.headers)
      },
      immediate: true
    }
  }
}
</script>
<style scoped>
 .truncate {
      max-width: 1px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
</style>
