import React from 'react'

export default function Details({params}: {params: {id: string}}) {
  return (
    <div>Обновления для {params.id}</div>
  )
}
