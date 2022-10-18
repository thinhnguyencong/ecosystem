import { configureStore } from '@reduxjs/toolkit'

import authSlice from '../services/auth/authSlice'
import userSlice from '../services/user/userSlice'

const store = configureStore({
  reducer: {
    auth: authSlice,
    user: userSlice,
  },
  devTools: true, // change to false when go to production
})

export default store