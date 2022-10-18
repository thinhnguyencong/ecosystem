import { configureStore } from '@reduxjs/toolkit'
import auctionSlice from '../services/auction/auctionSlice'

import authSlice from '../services/auth/authSlice'
import collectionSlice from '../services/collection/collectionSlice'
import userSlice from '../services/user/userSlice'

const store = configureStore({
  reducer: {
    auth: authSlice,
    user: userSlice,
    auction: auctionSlice,
    collection: collectionSlice
  },
  devTools: true, // change to false when go to production
})

export default store