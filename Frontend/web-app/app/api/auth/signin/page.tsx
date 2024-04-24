import EmptyFilter from '@/app/components/EmptyFilter'
import React from 'react'

export default function Page({searchParams}: {searchParams: {callbackUrl: string}}) {
  return (
    <EmptyFilter title="Вы должны быть зарегистрированы"
                 subtitle='Пожалуйста, кликните на вход в систему'
                 showLogin
                 callbackUrl={searchParams.callbackUrl}
    />
  )
}
