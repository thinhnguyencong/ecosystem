<template>
  <div>

      <div class="dms">
          <NavBar @onLayoutChange="onLayoutChange" @handleDrawer="handleDrawer"/>
          <div class="dms-home">
              <div class="row-head">
                  <div class="column-head">
                      <div class="column-head--firl" v-show="isShowColumn">
                          <div class="column-firl--row1">
                              <div class="column-row--number">120</div>
                              <div class="column-row--txt">
                                  <div class="column-row--icon">
                                      <img
                                         id="close"
                                         src="@/assets/img/column-close.svg"
                                         alt="error-icon"
                                      />
                                  </div>
                                  <div class="column-row--name">Pending</div>
                              </div>
                          </div>
                          <div class="column-firl--row2">
                              <div class="column-row--number">120</div>
                              <div class="column-row--txt">
                                  <div class="column-row--icon">
                                      <img
                                         id="close"
                                         src="@/assets/img/column-close.svg"
                                         alt="error-icon"
                                      />
                                  </div>
                                  <div class="column-row--name">Rejected</div>
                              </div>
                          </div>
                          <div class="column-firl--row3">
                              <div class="column-row--number">120</div>
                              <div class="column-row--txt">
                                  <div class="column-row--icon">
                                      <img
                                         id="successfully"
                                         src="@/assets/img/successfully.svg"
                                         alt="error-icon"
                                      />
                                  </div>
                                  <div class="column-row--name">Approved</div>
                              </div>
                          </div>
                      </div>

                      <div class="column-head--after">

                          <div class="column-head--menu">
                              <div class="menu-tabs">
                                  <div class="list-head--menu"
                                       v-for="(tabItem, index) in tabs"
                                       :key="index"
                                       @click="activeTab = index">

                                      <div class="menu-item" :class="{ menuActive: activeTab === index }">{{ tabItem }}</div>
                                  </div>
                              </div>

                              <div class="menu-icon--firl" @click="btnShowChart" custom-class="show-chart" >
                                  <img src="@/assets/img/Expand.svg" alt="error-icon" />
                              </div>
                          </div>
                          <div class="tabs-menu--active" v-if="activeTab === 0">
                              <div class="column-menu--icon">
                                  <div class="column-menu--add">
                                      <a data-toggle="modal" data-target="#modalCreateFolder" class="add-menu" href="#">
                                          <div class="add-new--firl">+</div>
                                          <div class="add-new--last">Add new file</div>
                                      </a>
                                  </div>
                                  <div class="list-menu--search">
                                      <div class="menu-row--search">
                                          <img src="@/assets/img/Search.svg" alt="error-search" />
                                          <input id="search" type="text" placeholder="Search" />
                                      </div>
                                      <div class="menu-row--format">
                                          <img src="@/assets/img/fileFormat.svg" alt="error-search" />
                                          <input id="format" type="text" placeholder="File format " />
                                      </div>
                                      <div class="menu-row--dates">
                                          <img src="@/assets/img/date.svg" alt="error-search" />
                                          <input id="dates" type="text" placeholder="Dates" />
                                      </div>
                                  </div>
                              </div>
                              <div class="column-table">
                                  <table id="listTable" class="table table-hover" data-pagination="true">
                                      <thead>
                                      <tr>
                                          <th scope="col" class="checkboxTable">
                                              <div class="head-item--checkbox"><input id="rd1" type="checkbox" name="rd" check></div>
                                          </th>
                                          <th scope="col">Name &nbsp; <i class="mdi mdi-arrow-down text-dark"></i></th>
                                          <th scope="col">Created by </th>
                                          <th scope="col">Size </th>
                                          <th scope="col">Create </th>
                                      </tr>
                                      </thead>
                                      <tbody>
                                      <tr role='button' @click="handleAccessFolder(folder._id)" v-for="(folder) in folders"
                                          :key="folder._id">
                                          <td>
                                              <input id="rd1" type="checkbox" name="rd" check>
                                          </td>
                                          <td class="truncate" scope="row">
                                              {{ folder.name }}
                                          </td>
                                          <td>-</td>
                                          <td>-</td>
                                          <td>{{(new Date(folder.createdAt)).toDateString()}}</td>
                                          <td>
                                              <img src="@/assets/img/star.svg" alt="error-icon">
                                          </td>
                                          <td @click.stop="">
                                              <div class="dropdown optionTable">
                                                  <div class="align-self-center" @click="openDropdown(folder._id)">
                                                      <v-btn flat icon color="indigo">
                                                          <v-icon data-toggle="tooltip" title="" color="#818181">
                                                              more_vert
                                                          </v-icon>
                                                      </v-btn>
                                                  </div>
                                                  <div v-click-outside="(event) => closeDropdown(folder._id, event)"
                                                       v-if="showMenu === folder._id" :id="'myDropdown-' + folder._id"
                                                       class="dropdown-content">
                                                      <div class="list-group">
                                                          <a v-if="folder.owner && folder.owner._id === authState.user._id"
                                                             @click="handleOpenModalRename(folder)"
                                                             class="list-group-item list-group-item-action">
                                                              <p class="h6 align-items-center d-flex">
                                                                  <i class="material-icons">drive_file_rename_outline</i>
                                                                  <span class="mt-2">Rename</span>
                                                              </p>
                                                          </a>
                                                          <a v-if="folder.owner && folder.owner._id === authState.user._id"
                                                             @click="handleOpenModalShare(folder)"
                                                             class="list-group-item list-group-item-action">
                                                              <p class="h6 align-items-center d-flex">
                                                                  <i class="material-icons">person_add</i>
                                                                  <span class="mt-2">Share</span>
                                                              </p>
                                                          </a>
                                                          <a @click="handleDownloadFolder(folder)"
                                                             class="list-group-item list-group-item-action">
                                                              <p class="h6 align-items-center d-flex">
                                                                  <i class="material-icons">download</i>
                                                                  <span class="mt-2">Download</span>
                                                              </p>
                                                          </a>
                                                          <a @click="handleHideFolder(folder)"
                                                             class="list-group-item list-group-item-action">
                                                              <p class="h6 align-items-center d-flex">
                                                                  <i class="material-icons">visibility_off</i>
                                                                  <span class="mt-2">Hide</span>
                                                              </p>
                                                          </a>
                                                      </div>
                                                  </div>
                                              </div>
                                          </td>
                                      </tr>
                                      <router-link tag="tr" class="item cursor-pointer" v-for="(file) in files" :key="file._id"
                                                   :to="$route.path === '/' ? `${$route.path}file/${file._id}` : `${$route.path}/file/${file._id}`">
                                          <th class="truncate" scope="row">
                                              <i :class="getClassFileType(JSON.parse(file.tokenURI).fileType)"></i>{{
                                                  JSON.parse(file.tokenURI).name
                                              }}
                                          </th>
                                          <td>{{ file.tokenId }}</td>
                                          <td>{{
                                                  file.lastAccess ? dayjs(file.lastAccess).format('HH:mm DD/MM/YYYY') : (new
                                                  Date(file.createdAt)).toDateString()
                                              }}</td>
                                          <td :class="getClassStatus(file.status)">{{ file.status }}</td>
                                          <td>{{ file.owner.name }}</td>
                                          <td>{{ niceBytes((JSON.parse(file.tokenURI).size))}}</td>
                                          <td>
                                              <v-btn flat icon color="indigo">
                                                  <v-icon data-toggle="tooltip" title="" color="black">
                                                      visibility
                                                  </v-icon>
                                              </v-btn>
                                              <span v-if="isLoadingDownload.id === file._id && isLoadingDownload.value"
                                                    class="spinner-border text-dark mr-2 mt-2" role="status">
                                    <span class="sr-only">Loading...</span>
                                </span>
                                              <span v-else @click.stop="" @click="download(file)">
                                    <v-btn flat icon color="indigo">
                                        <v-icon data-toggle="tooltip" title="" color="black">
                                            download
                                        </v-icon>
                                    </v-btn>
                                </span>
                                          </td>
                                      </router-link>

                                      </tbody>
                                  </table>
                              </div>
                              <div class="paging-table">
                                  <div class="paging">
                                      <ul class="pagination">
                                          <li class="page-item disabled" tabindex="-1">
                                              <a class="page-link border-boundary" href="#">
                                                  <img
                                                      id="arrow-left"
                                                      src="@/assets/img/arrow_left.svg"
                                                      alt=""
                                                  />
                                              </a>
                                          </li>
                                          <li class="page-item active">
                                              <a class="page-link" href="#">1</a>
                                          </li>
                                          <li class="page-item"><a class="page-link" href="#">2</a></li>
                                          <li class="page-item">
                                              <a class="page-link" href="#">...</a>
                                          </li>
                                          <li class="page-item">
                                              <a class="page-link" href="#">52</a>
                                          </li>
                                          <li class="page-item">
                                              <a class="page-link border-boundary" href="#">
                                                  <img
                                                      id="arrow-right"
                                                      src="@/assets/img/arrow_right.svg"
                                                      alt=""
                                                  />
                                              </a>
                                          </li>
                                      </ul>
                                  </div>
                              </div>
                              <div class="paging-record">
                                  <div class="record-number">
                                      <div class="record-number-txt">5 Lines</div>
                                      <div class="record-number-dropdown">
                                          <img
                                              id="paging-dropdown"
                                              src="@/assets/img/dropbottom.svg"
                                              alt=""
                                          />
                                      </div>
                                  </div>
                              </div>
                          </div>
                          <div class="tabs-menu--active" v-if="activeTab === 1">
                              <div class="column-menu--icon">
                                  <div class="column-menu--add">
                                      <a data-toggle="modal" data-target="#modalCreateFolder" class="add-menu" href="#">
                                          <div class="add-new--firl">+</div>
                                          <div class="add-new--last">Add new file</div>
                                      </a>
                                  </div>
                                  <div class="list-menu--search">
                                      <div class="menu-row--search">
                                          <img src="@/assets/img/Search.svg" alt="error-search" />
                                          <input id="search" type="text" placeholder="Search" />
                                      </div>
                                      <div class="menu-row--format">
                                          <img src="@/assets/img/fileFormat.svg" alt="error-search" />
                                          <input id="format" type="text" placeholder="File format " />
                                      </div>
                                      <div class="menu-row--dates">
                                          <img src="@/assets/img/date.svg" alt="error-search" />
                                          <input id="dates" type="text" placeholder="Dates" />
                                      </div>
                                  </div>
                              </div>
                              <div class="column-table">
                                  <table id="table-homePage">
                                      <thead>
                                      <tr>
                                          <th><input type="checkbox" /></th>
                                          <th>
                                              <div class="head-txt">
                                                  <div class="head-name">Name</div>
                                                  <div class="head-name">
                                                      <img
                                                          src="@/assets/img/dropdownTable.svg"
                                                          alt="error-dropdown"
                                                      />
                                                  </div>
                                              </div>
                                          </th>
                                          <th>Location</th>
                                          <th>Size</th>
                                          <th>Create</th>
                                      </tr>
                                      </thead>
                                      <tbody>
                                      <tr>
                                          <td><input type="checkbox" /></td>
                                          <td>Smart Contract.pdf</td>
                                          <td>Presentation</td>
                                          <td>2 MB</td>
                                          <td>12 Dec 2022, 12:12</td>
                                          <td class="optionTable">
                                              <img
                                                  src="@/assets/img/folder-option.svg"
                                                  alt="error-option"
                                              />
                                          </td>
                                      </tr>
                                      <tr>
                                          <td><input type="checkbox" /></td>
                                          <td>ChatGPT.pdf</td>
                                          <td>Presentation</td>
                                          <td>2 MB</td>
                                          <td>12 Dec 2022, 12:12</td>
                                          <td class="optionTable">
                                              <img
                                                  src="@/assets/img/folder-option.svg"
                                                  alt="error-option"
                                              />
                                          </td>
                                      </tr>
                                      <tr>
                                          <td><input type="checkbox" /></td>
                                          <td>Testcase.pdf</td>
                                          <td>Presentation</td>
                                          <td>2 MB</td>
                                          <td>12 Dec 2022, 12:12</td>
                                          <td class="optionTable">
                                              <img
                                                  src="@/assets/img/folder-option.svg"
                                                  alt="error-option"
                                              />
                                          </td>
                                      </tr>
                                      </tbody>
                                  </table>
                              </div>
                              <div class="paging-table">
                                  <div class="paging">
                                      <ul class="pagination">
                                          <li class="page-item disabled" tabindex="-1">
                                              <a class="page-link border-boundary" href="#">
                                                  <img
                                                      id="arrow-left"
                                                      src="@/assets/img/arrow_left.svg"
                                                      alt=""
                                                  />
                                              </a>
                                          </li>
                                          <li class="page-item active">
                                              <a class="page-link" href="#">1</a>
                                          </li>
                                          <li class="page-item"><a class="page-link" href="#">2</a></li>
                                          <li class="page-item">
                                              <a class="page-link" href="#">...</a>
                                          </li>
                                          <li class="page-item">
                                              <a class="page-link" href="#">52</a>
                                          </li>
                                          <li class="page-item">
                                              <a class="page-link border-boundary" href="#">
                                                  <img
                                                      id="arrow-right"
                                                      src="@/assets/img/arrow_right.svg"
                                                      alt=""
                                                  />
                                              </a>
                                          </li>
                                      </ul>
                                  </div>
                              </div>
                              <div class="paging-record">
                                  <div class="record-number">
                                      <div class="record-number-txt">5 Lines</div>
                                      <div class="record-number-dropdown">
                                          <img
                                              id="paging-dropdown"
                                              src="@/assets/img/dropbottom.svg"
                                              alt=""
                                          />
                                      </div>
                                  </div>
                              </div>
                          </div>
                          <div class="tabs-menu--active" v-if="activeTab === 2">
                              <div class="column-menu--icon">
                                  <div class="column-menu--add">
                                      <a data-toggle="modal" data-target="#modalCreateFolder" class="add-menu" href="#">
                                          <div class="add-new--firl">+</div>
                                          <div class="add-new--last">Add new file</div>
                                      </a>
                                  </div>
                                  <div class="list-menu--search">
                                      <div class="menu-row--search">
                                          <img src="@/assets/img/Search.svg" alt="error-search" />
                                          <input id="search" type="text" placeholder="Search" />
                                      </div>
                                      <div class="menu-row--format">
                                          <img src="@/assets/img/fileFormat.svg" alt="error-search" />
                                          <input id="format" type="text" placeholder="File format " />
                                      </div>
                                      <div class="menu-row--dates">
                                          <img src="@/assets/img/date.svg" alt="error-search" />
                                          <input id="dates" type="text" placeholder="Dates" />
                                      </div>
                                  </div>
                              </div>
                              <div class="column-table">
                                  <table id="table-homePage">
                                      <thead>
                                      <tr>
                                          <th><input type="checkbox" /></th>
                                          <th>
                                              <div class="head-txt">
                                                  <div class="head-name">Name</div>
                                                  <div class="head-name">
                                                      <img
                                                          src="@/assets/img/dropdownTable.svg"
                                                          alt="error-dropdown"
                                                      />
                                                  </div>
                                              </div>
                                          </th>
                                          <th>Location</th>
                                          <th>Size</th>
                                          <th>Create</th>
                                      </tr>
                                      </thead>
                                      <tbody>
                                      <tr>
                                          <td><input type="checkbox" /></td>
                                          <td>Smart Contract.pdf</td>
                                          <td>Presentation</td>
                                          <td>2 MB</td>
                                          <td>12 Dec 2022, 12:12</td>
                                          <td class="optionTable">
                                              <img
                                                  src="@/assets/img/folder-option.svg"
                                                  alt="error-option"
                                              />
                                          </td>
                                      </tr>
                                      <tr>
                                          <td><input type="checkbox" /></td>
                                          <td>ChatGPT.pdf</td>
                                          <td>Presentation</td>
                                          <td>2 MB</td>
                                          <td>12 Dec 2022, 12:12</td>
                                          <td class="optionTable">
                                              <img
                                                  src="@/assets/img/folder-option.svg"
                                                  alt="error-option"
                                              />
                                          </td>
                                      </tr>
                                      <tr>
                                          <td><input type="checkbox" /></td>
                                          <td>Testcase.pdf</td>
                                          <td>Presentation</td>
                                          <td>2 MB</td>
                                          <td>12 Dec 2022, 12:12</td>
                                          <td class="optionTable">
                                              <img
                                                  src="@/assets/img/folder-option.svg"
                                                  alt="error-option"
                                              />
                                          </td>
                                      </tr>
                                      </tbody>
                                  </table>
                              </div>
                              <div class="paging-table">
                                  <div class="paging">
                                      <ul class="pagination">
                                          <li class="page-item disabled" tabindex="-1">
                                              <a class="page-link border-boundary" href="#">
                                                  <img
                                                      id="arrow-left"
                                                      src="@/assets/img/arrow_left.svg"
                                                      alt=""
                                                  />
                                              </a>
                                          </li>
                                          <li class="page-item active">
                                              <a class="page-link" href="#">1</a>
                                          </li>
                                          <li class="page-item"><a class="page-link" href="#">2</a></li>
                                          <li class="page-item">
                                              <a class="page-link" href="#">...</a>
                                          </li>
                                          <li class="page-item">
                                              <a class="page-link" href="#">52</a>
                                          </li>
                                          <li class="page-item">
                                              <a class="page-link border-boundary" href="#">
                                                  <img
                                                      id="arrow-right"
                                                      src="@/assets/img/arrow_right.svg"
                                                      alt=""
                                                  />
                                              </a>
                                          </li>
                                      </ul>
                                  </div>
                              </div>
                              <div class="paging-record">
                                  <div class="record-number">
                                      <div class="record-number-txt">5 Lines</div>
                                      <div class="record-number-dropdown">
                                          <img
                                              id="paging-dropdown"
                                              src="@/assets/img/dropbottom.svg"
                                              alt=""
                                          />
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                      <div class="column-head--firlChart" v-show="isShowChart">
                          <div class="chart-title">Summary</div>
                          <div class="chart-page">
                              <div class="hightchart">
                                  <high-charts />
                              </div>
                              <div class="chart-txt">
                                  <div class="chart-txt--name">Total</div>
                                  <div class="chart-txt--count">300</div>
                              </div>
                          </div>

                          <div class="chart-note">
                              <ul class="chart-note--list">
                                  <li class="chart-note--item">
                                      <div class="note-item">
                                          <div class="note-item--pending"></div>
                                          <div class="note-item--name">Pending</div>
                                      </div>
                                      <div class="note-item--count">100</div>
                                  </li>
                                  <li class="chart-note--item">
                                      <div class="note-item">
                                          <div class="note-item--rejected"></div>
                                          <div class="note-item--name">Rejected</div>
                                      </div>
                                      <div class="note-item--count">100</div>
                                  </li>
                                  <li class="chart-note--item">
                                      <div class="note-item">
                                          <div class="note-item--approved"></div>
                                          <div class="note-item--name">Approved</div>
                                      </div>
                                      <div class="note-item--count">100</div>
                                  </li>
                              </ul>
                          </div>
                      </div>
                  </div>
              </div>
              <div class="row-content">
                  <div class="row-content--column">
                      <div class="column-content--head">
                          <div class="column-head--title">Recent</div>
                          <div class="column-head--view">View all</div>
                      </div>
                      <ul class="listItem">
                          <li class="listItem-file">
                              <div class="listItem-file--firl">
                                  <div class="file-item--txt">
                                      <div class="file-item--icon">
                                          <img src="@/assets/img/pdf.svg" alt="error-icon" />
                                      </div>
                                      <div class="file-item--name">Smart Contract.pdf</div>
                                  </div>
                                  <div class="file-item--date">1 minute ago</div>
                              </div>
                              <div class="listItem-file--last">
                                  <div class="file-name--capacity">HuongNTM</div>
                                  <div class="file-option--capacity"></div>
                                  <div class="file-mb--capacity">2 MB</div>
                              </div>
                          </li>
                          <li class="listItem-file">
                              <div class="listItem-file--firl">
                                  <div class="file-item--txt">
                                      <div class="file-item--icon">
                                          <img src="@/assets/img/pdf.svg" alt="error-icon" />
                                      </div>
                                      <div class="file-item--name">Smart Contract.pdf</div>
                                  </div>
                                  <div class="file-item--date">1 minute ago</div>
                              </div>
                              <div class="listItem-file--last">
                                  <div class="file-name--capacity">HuongNTM</div>
                                  <div class="file-option--capacity"></div>
                                  <div class="file-mb--capacity">2 MB</div>
                              </div>
                          </li>
                          <li class="listItem-file">
                              <div class="listItem-file--firl">
                                  <div class="file-item--txt">
                                      <div class="file-item--icon">
                                          <img src="@/assets/img/pdf.svg" alt="error-icon" />
                                      </div>
                                      <div class="file-item--name">Smart Contract.pdf</div>
                                  </div>
                                  <div class="file-item--date">1 minute ago</div>
                              </div>
                              <div class="listItem-file--last">
                                  <div class="file-name--capacity">HuongNTM</div>
                                  <div class="file-option--capacity"></div>
                                  <div class="file-mb--capacity">2 MB</div>
                              </div>
                          </li>
                      </ul>
                  </div>
                  <div class="row-content--column">
                      <div class="column-content--head">
                          <div class="column-head--title">Recent</div>
                          <div class="column-head--view">View all</div>
                      </div>
                      <ul class="listItem">
                          <li class="listItem-file">
                              <div class="listItem-file--firl">
                                  <div class="file-item--txt">
                                      <div class="file-item--icon">
                                          <img src="@/assets/img/pdf.svg" alt="error-icon" />
                                      </div>
                                      <div class="file-item--name">Smart Contract.pdf</div>
                                  </div>
                                  <div class="file-item--date">1 minute ago</div>
                              </div>
                              <div class="listItem-file--last">
                                  <div class="file-name--capacity">HuongNTM</div>
                                  <div class="file-option--capacity"></div>
                                  <div class="file-mb--capacity">2 MB</div>
                              </div>
                          </li>
                          <li class="listItem-file">
                              <div class="listItem-file--firl">
                                  <div class="file-item--txt">
                                      <div class="file-item--icon">
                                          <img src="@/assets/img/pdf.svg" alt="error-icon" />
                                      </div>
                                      <div class="file-item--name">Smart Contract.pdf</div>
                                  </div>
                                  <div class="file-item--date">1 minute ago</div>
                              </div>
                              <div class="listItem-file--last">
                                  <div class="file-name--capacity">HuongNTM</div>
                                  <div class="file-option--capacity"></div>
                                  <div class="file-mb--capacity">2 MB</div>
                              </div>
                          </li>
                          <li class="listItem-file">
                              <div class="listItem-file--firl">
                                  <div class="file-item--txt">
                                      <div class="file-item--icon">
                                          <img src="@/assets/img/pdf.svg" alt="error-icon" />
                                      </div>
                                      <div class="file-item--name">Smart Contract.pdf</div>
                                  </div>
                                  <div class="file-item--date">1 minute ago</div>
                              </div>
                              <div class="listItem-file--last">
                                  <div class="file-name--capacity">HuongNTM</div>
                                  <div class="file-option--capacity"></div>
                                  <div class="file-mb--capacity">2 MB</div>
                              </div>
                          </li>
                      </ul>
                  </div>
                  <div class="row-content--column">
                      <div class="column-content--head">
                          <div class="column-head--title">Recent</div>
                          <div class="column-head--view">View all</div>
                      </div>
                      <ul class="listItem">
                          <li class="listItem-file">
                              <div class="listItem-file--firl">
                                  <div class="file-item--txt">
                                      <div class="file-item--icon">
                                          <img src="@/assets/img/pdf.svg" alt="error-icon" />
                                      </div>
                                      <div class="file-item--name">Smart Contract.pdf</div>
                                  </div>
                                  <div class="file-item--date">1 minute ago</div>
                              </div>
                              <div class="listItem-file--last">
                                  <div class="file-name--capacity">HuongNTM</div>
                                  <div class="file-option--capacity"></div>
                                  <div class="file-mb--capacity">2 MB</div>
                              </div>
                          </li>
                          <li class="listItem-file">
                              <div class="listItem-file--firl">
                                  <div class="file-item--txt">
                                      <div class="file-item--icon">
                                          <img src="@/assets/img/pdf.svg" alt="error-icon" />
                                      </div>
                                      <div class="file-item--name">Smart Contract.pdf</div>
                                  </div>
                                  <div class="file-item--date">1 minute ago</div>
                              </div>
                              <div class="listItem-file--last">
                                  <div class="file-name--capacity">HuongNTM</div>
                                  <div class="file-option--capacity"></div>
                                  <div class="file-mb--capacity">2 MB</div>
                              </div>
                          </li>
                          <li class="listItem-file">
                              <div class="listItem-file--firl">
                                  <div class="file-item--txt">
                                      <div class="file-item--icon">
                                          <img src="@/assets/img/pdf.svg" alt="error-icon" />
                                      </div>
                                      <div class="file-item--name">Smart Contract.pdf</div>
                                  </div>
                                  <div class="file-item--date">1 minute ago</div>
                              </div>
                              <div class="listItem-file--last">
                                  <div class="file-name--capacity">HuongNTM</div>
                                  <div class="file-option--capacity"></div>
                                  <div class="file-mb--capacity">2 MB</div>
                              </div>
                          </li>
                      </ul>
                  </div>
              </div>
          </div>
      </div>
<!--    <div class="container">-->
<!--      <v-tabs icons-and-text class="h-100" fixed-tabs grow v-model="active">-->
<!--        <v-tabs-slider :color="active==2 ? 'green' : active== 1 ? 'red' : 'blue'"></v-tabs-slider>-->
<!--        <v-tab color="success" class="document-tab-0 border-bottom" active-class="text-primary font-weight-bold" :key="0" >-->
<!--              <span class="text-primary">All Documents</span>-->
<!--              <span class="text-primary material-icons">assignment</span>-->
<!--        </v-tab>-->
<!--        <v-tab class="document-tab-1 border-bottom" active-class="text-danger font-weight-bold" :key="1">-->
<!--          <span class="text-danger">Needs to sign</span>-->
<!--          <span class="text-danger material-icons">history_edu</span>-->
<!--        </v-tab>-->
<!--        <v-tab class="document-tab-2 border-bottom text-success" active-class="text-success font-weight-bold" :key="2">-->
<!--           <span class="text-success">Signed</span>-->
<!--           <span class="text-success material-icons">assignment_turned_in</span>-->
<!--        </v-tab>-->
<!--        <v-tab-item :key="0">-->
<!--          <br>-->
<!--          <div v-if="active==0">-->
<!--            <MainView :folders="[]" :files="files" :layoutProps="layout"/>-->
<!--          </div>-->
<!--        </v-tab-item>-->
<!--        <v-tab-item :key="1">-->
<!--          <br>-->
<!--          <div v-if="active==1">-->
<!--            <MainView :folders="[]" :files="getPendingDocs()" :layoutProps="layout"/>-->
<!--          </div>-->
<!--        </v-tab-item>-->
<!--        <v-tab-item :key="2">-->
<!--          <br>-->
<!--          <div v-if="active==2">-->
<!--            <MainView :folders="[]" :files="getSignedDocs()" :layoutProps="layout"/>-->
<!--          </div>-->
<!--        </v-tab-item>-->
<!--      </v-tabs>-->

<!--    </div>-->
  </div>

</template>
<script setup>
import ModalFileDetails from './modal/ModalFileDetails.vue';

import NavBar from '../../components/layout/NavBar.vue';
import MainView from '../../components/MainView.vue';
import HighCharts from "@/components/HighCharts.vue";
import {getClassFileType, getClassStatus, niceBytes} from "@/helpers";
</script>
<script>
  export default {
      props: {
          folders: {
              type: Array,
              default() { return []; }
          },
          files: {
              type: Array,
              default() { return []; }
          },
          layoutProps: {
              type: String,
              default() { return "grid"; }
          },

      },
    components: { ModalFileDetails, NavBar, MainView,HighCharts },
    data() {
      return {
        files: [],
        folders: [],
        showModal: false,
        active: 1,
        layout: "",
          isShowColumn: true,
          isShowChart: false,
          tabs: ["Pending", "Approved", "Rejected"],
          activeTab: 0,



          isLoadingDownload: {
              id: null,
              value: false
          },
          showMenu: "",
          folderShare: {},
          dayjs: dayjs,
      }
    },
    mounted() {
      this.$router.push(this.$route.path)
      console.log("home");
      this.layout = this.layoutProps;
    },
    created() {
        this.$store.dispatch("auth/sidebarActive", "home")
        this.callAPI()
    },
    methods: {
        handleAccessFolder(id) {
            this.$router.push("/folder/" + id);
            this.itemSelected = id;
        },
        btnShowChart() {
            this.isShowColumn = !this.isShowColumn
            this.isShowChart = !this.isShowChart
        },
        handleDrawer() {
            console.log(this.drawerVisible);
            this.drawerVisible = !this.drawerVisible
            console.log(this.drawerVisible);
            if(this.drawerVisible) {
                this.transition = 'slide-fade-reverse'
            }else {
                this.transition = 'slide-fade'
            }
        },
      onLayoutChange(layout) {
        this.layout = layout
      },


        openDropdown(id) {
            this.showMenu = id;

        },
        closeDropdown(id) {
            this.showMenu = "";
        },

        handleOpenModalRename(folder) {
            this.folderRename = folder
            this.showMenu = ""
        },
        handleCloseModalRename() {
            this.folderRename = {}
        },
        handleOpenModalShare(folder) {
            console.log(folder);
            this.folderShare = folder
            this.showMenu = ""
        },
        handleCloseModalShare() {
            this.folderShare = {}
        },
        handleHideFolder() {

        },
        async handleDownloadFolder(folder) {
            this.showMenu = ""
            if(!this.documentState.treeFolder[folder._id]) {
                await this.$store.dispatch("document/getTreeFolder", { type: "folder", folderId: folder._id })
            }
            let zip = new JSZip()
            const toastZipping = toast.info("Zipping folder...", {
                position: "bottom-left",
                timeout: 0,
                closeOnClick: true,
                draggable: true,
                draggablePercent: 0.6,
                showCloseButtonOnHover: true,
                hideProgressBar: true,
                closeButton: "button",
                icon: true,
                rtl: false
            });
            const ipfs = await IpfsClient()
            if (!ipfs) {
                return
            }
            await this.zipFolder(ipfs, this.documentState.treeFolder[folder._id][0].children, zip)
            toast.success("Successfully zipping "+ '"' + folder.name+ '"', {
                position: "bottom-left",
                timeout: 1500,
                closeOnClick: true,
                draggable: true,
                draggablePercent: 0.6,
                showCloseButtonOnHover: true,
                hideProgressBar: false,
                closeButton: "button",
                icon: true,
                rtl: false
            });
            toast.dismiss(toastZipping)
            zip.generateAsync({ type: "blob" })
                .then(function (content) {
                    let link = document.createElement('a');
                    link.href = window.URL.createObjectURL(content);
                    let fileName = folder.name;
                    link.download = fileName;
                    link.click();
                }).catch(error => {
                console.log(error);
            });
        },
        async zipFolder(ipfs, treeFolder, zip) {
            console.log(treeFolder);
            for (let child of treeFolder) {
                if(!child.children){
                    let res = await ipfs.get(child.data.hash)
                    let resultDecrypt = decrypt(res[0].content, child.data.key);
                    let tokenUri = JSON.parse(child.data.tokenURI);
                    zip.file(tokenUri.name, resultDecrypt);
                }else {
                    let folder = zip.folder(`${child.name}`);
                    this.zipFolder(ipfs, child.children, folder)
                }
            }
        },
        getClassFileType: getClassFileType,
        niceBytes: niceBytes,
        getClassStatus: getClassStatus,

        async download(file) {
            this.isLoadingDownload.value = true;
            this.isLoadingDownload.id = file._id;
            const ipfs = await IpfsClient()
            if (!ipfs) {
                this.isLoadingDownload.value = false;
                console.log(error);
                alert("No file to download");
            }
            let res = await ipfs.get(file.hash)
            if (res) {
                console.log(res[0].content);
                let resultDecrypt = decrypt(res[0].content, file.key);
                console.log("resultDecrypt", resultDecrypt);
                let tokenUri = JSON.parse(file.tokenURI);
                console.log("tokenUri", tokenUri);
                let blob = new Blob([resultDecrypt.buffer], { type: tokenUri.fileType });
                let link = document.createElement("a");
                link.href = window.URL.createObjectURL(blob);
                let fileName = tokenUri.name;
                link.download = fileName;
                console.log("link", link);
                link.click();
                this.isLoadingDownload.value = false;
            }
        },
    },
    computed: {
        documentState() { return this.$store.state.document; },
        authState() { return this.$store.state.auth; },
    },
    watch: {
        "$route": {
            immediate: true,
            handler: function (newVal, oldVal) {
                this.showModal = newVal.meta && newVal.meta.showModal;
            }
        },
        layoutProps: {
            immediate: true,
            handler: function (newVal, oldVal) {
                this.layout = newVal;
            }
        },
    },
  }
</script>

<style lang="scss" scoped>
@import "@/assets/style/_reset.scss";
@import "@/assets/style/_global.scss";
.dms {
}
.column-menu--add {
    width: 100%;
}
.optionTable {
    display: flex;
    justify-content: end;
    cursor: pointer;
}
.menuActive {
    font-weight: 600;
    font-size: 14px;
    color: var(--text-color-active) !important;
    background: var(--backgroud);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}
.add-new--firl {
    font-size: 16px;
    color: var(--backgroud);
    padding: 2px 10px;
    background-color: var(--text-color-active);
    border-radius: 8px;
}
.add-new--last {
    font-weight: 600;
    font-size: 12px;
    color: var(--text-color--1);
}
.dms-home {
  width: 100%;
  background-color: #FAFAFA;
  padding: 20px 16px;
}
.row-head {

  &--title {
    font-weight: 600;
    font-size: 12px;
    color: #12131C;
    margin-bottom: 20px;
  }
}

::v-deep .highcharts-credits {
  display: none;
}
.chart-title {
  padding: 16px 0;
  text-align: center;
  height: 56px;
  border-bottom:1px solid #EDEDED;
  font-weight: 700;
  font-size: 18px;
  color: #12131C;
  background-color: #FFFFFF;
  border-top-left-radius: 16px;
  border-top-right-radius: 16px;
}
::v-deep .highcharts-label {
  text {
    display: none;
  }
}

::v-deep .highcharts-data-label-connector {
  display: none;
}

::v-deep .highcharts-screen-reader-region-before-0 {
  display: none;
}

.chart-note {
  width: 100%;
  background-color: #FFFFFF;
  padding: 0 24px;
  border-bottom-left-radius: 16px;
  border-bottom-right-radius: 16px;
  &--item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 16px 0;
    border-bottom: 1px solid #EDEDED;
  }
}
::v-deep .highcharts-exporting-group {
  display: none;
}

#chart {

  width: 100% !important;
  height: 262px !important;
  background-color: #FFFFFF;
  padding: 6px 0;
  overflow: hidden;
}
.chart-page {
  position: relative;
}
.add-menu {
    display: flex;
    align-items: center;
    gap: 0 8px;
}

.chart-txt {
  position: absolute;
  top: 49%;
  left: 50%;
  transform: translate(-50%,-50%);
  z-index: 1;
  width: 155px;
  height: 155px;
  background-color: #FFFFFF;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  border-radius: 50%;
  &--name {
    position: absolute;
    top: 35%;
    left: 50%;
    transform: translate(-50%,-50%);
    font-weight: 600;
    font-size: 24px;
    color: #32373D;
  }
  &--count {
    position: absolute;
    top: 60%;
    left: 50%;
    transform: translate(-50%,-50%);
    font-weight: 600;
    font-size: 40px;
    color: #12131C;

  }
}
.note-item--count {
  font-weight: 700;
  font-size: 18px;
  color: #12131C;
}
.note-item--name {
  font-weight: 500;
  font-size: 14px;
  color: #12131C;
}
.note-item {
  display: flex;
  align-items: center;
  gap: 0 8px;
  &--pending {
    width: 12px;
    height: 12px;
    background: #EA7F00;
    border-radius: 50%;
  }
  &--rejected {
    width: 12px;
    height: 12px;
    background: #F94D4D;
    border-radius: 50%;
  }
  &--approved {
    width: 12px;
    height: 12px;
    background: #28B78D;
    border-radius: 50%;
  }
}

.column-head {
  display: flex;
  gap: 0 16px;
  &--firl {
    display: grid;
    gap: 16px 0;
    max-width: 256px;
    width: 100%;
  }
  &--after {
    width: 100%;
    background: #FFFFFF;
    border: 1px solid #EDEDED;
    border-radius: 16px;

  }
  &--firlChart {
    max-width: 424px;
    width: 100%;
    border-radius: 16px;
    border: 1px solid #EDEDED;
  }
}
::v-deep .highcharts-title {
  display: none;
}

.column-firl--row1 {
  background: #FFEFE2;
  border-radius: 16px;
  width: 100%;
  padding: 16px 27px;
}
.column-firl--row2 {
  background: #FFE2E2;
  border-radius: 16px;
  width: 100%;
  padding: 16px 27px;
}
.column-firl--row3 {
  background: #EFFCEF;
  border-radius: 16px;
  width: 100%;
  padding: 16px 27px;
}

.column-row--number {
  text-align: center;
  font-weight: 600;
  font-size: 64px;
  color: #12131C;
}
.column-row--txt {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0 4px;
}
.column-row--name {
  font-weight: 600;
  font-size: 14px;
  color: #12131C;
}
#successfully {
  width: 12px;
  height: auto;
}
.column-head--menu {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 16px;
  border-bottom: 1px solid #EDEDED;
  position: relative;
}
.menu-icon--firl {
  position: absolute;
  top: 30px;
  right: 16px;
  cursor: pointer;

}
.menu-tabs {
    display: flex;
    border-radius: 12px;
    background: #F7F7F8;
}
.list-head--menu {
  padding: 8px;
  display: flex;
  justify-content: center;
  align-items: center;

}

.column-menu--icon {
  padding: 16px;
  display: flex;
  justify-content: end;
  align-items: center;
  width: 100%;
}
.menu-item {
  font-weight: 600;
  font-size: 14px;
  color: #12131C;
  padding: 8px 31px;
  cursor: pointer;
}
.menu-item--active {
  font-weight: 600;
  font-size: 14px;
  color: #3C46F5;
  padding: 8px 31px;
  background: #FFFFFF;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
}
.list-menu--search {
  display: flex;
  align-items: center;
  width: 100%;
  gap: 0 24px;
}

.menu-row--search {
  background: #F7F7F8;
  border: 1px solid #EDEDED;
  border-radius: 500px;
  padding: 6px 8px;
  max-width: 300px;
  width: 100%;
  display: flex;
  align-items: center;
  gap:0 8px;
}
.menu-row--format {
  background: #F7F7F8;
  border: 1px solid #EDEDED;
  border-radius: 500px;
  padding: 6px 8px;
  max-width: 300px;
  width: 100%;
  display: flex;
  align-items: center;
  gap:0 8px;
}
.menu-row--dates {
  background: #F7F7F8;
  border: 1px solid #EDEDED;
  border-radius: 500px;
  padding: 6px 8px;
  max-width: 300px;
  width: 100%;
  display: flex;
  align-items: center;
  gap:0 8px;
}
#search {
  background: #F7F7F8;
  color: #12131C;
  font-weight: 500;
  font-size: 14px;
  &::placeholder {
    color: #C1C0C9;
    font-weight: 500;
    font-size: 14px;
  }
}
#format {
  background: #F7F7F8;
  color: #12131C;
  font-weight: 500;
  font-size: 14px;
  &::placeholder {
    color: #C1C0C9;
    font-weight: 500;
    font-size: 14px;
  }
}
#dates {
  background: #F7F7F8;
  color: #12131C;
  font-weight: 500;
  font-size: 14px;
  &::placeholder {
    color: #C1C0C9;
    font-weight: 500;
    font-size: 14px;
  }
}

.column-table {
  padding: 0 16px;
}
#table-homePage {
  width: 100%;
}
#table-homePage th {
  padding: 10px 8px ;
  font-weight: 600;
  font-size: 12px;
  color: #6F7180;
}

#table-homePage td {
  padding: 10px 8px ;
  font-weight: 500;
  font-size: 14px;
  color: #12131C;
}


#table-homePage tr {
  border-bottom: 1px solid #EDEDED;
}

#table-homePage tbody tr:last-child {
  border: none;
}

.head-txt {
  display: flex;
  align-items: center;
  gap: 0 4px;
}


// check radio
tr td input[type="checkbox"]:checked ~ * {
  user-select: none;
}
tr td {
  vertical-align: middle;
}

tr td input[type="checkbox"] {
  margin: 0;
}

tr td input[type="checkbox"]:checked {
  position: relative;
}
tr th input[type="checkbox"]:checked {
  position: relative;
}
tr th input[type="checkbox"]:checked::before {
  content: "\2714";
  color: #FFFFFF;
  font-size: 12px;
  text-align: center;
  display: block;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}


tr td input[type="checkbox"]:checked::before {
  content: "\2714";
  color: #FFFFFF;
  font-size: 12px;
  text-align: center;
  display: block;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

// paging
.column-head--after {
  position: relative;
  height: 500px;
}

.paging-table {
  position: absolute;
  bottom: 16px;
  left: 50%;
  transform: translateX(-50%);
}
.paging {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 16px;
  &-record {
    position: absolute;
    right: 16px;
    bottom: 16px;
    padding: 6px 8px;
    border: 1px solid #EDEDED;
    border-radius: 12px;
    cursor: pointer;
  }
}
.record-number-txt {
  font-weight: 500;
  font-size: 14px;
  color: #6F7180;
}
#paging-dropdown {
  width: 12px;
  height: 6px;
}
.record-number {
  display: flex;
  align-items: center;
  gap: 0 8px;
}


.border-boundary {
  border: none !important;
}
#arrow-right {
  width: 10px;
}
#arrow-left {
  width: 10px;
}
::v-deep .page-item {
  padding: 0 8px;
}
::v-deep .page-item  {
    padding: 0 8px;
}
.page-item.active .page-link {
    background-color: var(--text-color-active);
    border-color: var(--text-color-active);
}

::v-deep .page-link {
  border-radius: 8px;
  padding: 8px 15px !important;
  color: #6F7180;
  border: 1px solid #EDEDED;
  &:focus {
    box-shadow: none !important;
  }
}

.row-content {
  margin-top: 16px;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  gap:  0 16px;
  width: 100%;

  &--column {
    background: #FFFFFF;
    border: 1px solid #EDEDED;
    border-radius: 16px;
    width: calc( 100% / 3 - 16px );
  }
}
.column-content--head {
  padding: 16px;
  border-bottom: 1px solid #EDEDED;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.column-head--title {
  font-weight: 700;
  font-size: 18px;
  color: #12131C;
}
.column-head--view {
  font-weight: 500;
  font-size: 14px;
  color: #2A85FF;
  cursor: pointer;
}
.listItem {
  padding: 16px;
}
.listItem-file {
  padding: 16px 0;
  border-bottom: 1px solid #EDEDED;
  &--firl {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 0 16px;
    margin-bottom: 4px;

  }
  &--last {
    display: flex;
    align-items: center;
    gap:  0 8px;
  }
}
.listItem-file:last-child {
  padding: 0;
  border: 0;
}
.file-item--txt {
  display: flex;
  align-items: center;
  gap: 0 8px;
}
.file-item--name {
  font-weight: 600;
  font-size: 14px;
  color: #12131C;
}
.file-item--date {
  font-size: 12px;
  color: #6F7180;
}
.file-name--capacity {
  font-size: 12px;
  color: #6F7180;
}
.file-mb--capacity {
  font-size: 12px;
  color: #6F7180;
}

.file-option--capacity {
  width: 4px;
  height: 4px;
  background-color: #6F7180;
  border-radius: 50%;
}

.show-chart .tooltip-inner {
  background: #32373D;
  border: 1px solid rgba(255, 255, 255, 0.12);
  border-radius: 8px;
  padding: 8px 12px;
  font-weight: 500;
  font-size: 12px;
  color: #EFEFEF;
}

.show-chart .arrow::before {
  border-right-color: #32373D;
  border-width: 8px 8px 0;
}

</style>
