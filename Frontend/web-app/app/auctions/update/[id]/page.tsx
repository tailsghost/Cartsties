import Heading from '@/app/components/Heading'
import React from 'react'
import AuctionForm from '../../AuctionForm'
import { getDetailedValidData } from '@/app/actions/auctionActions'

export default async function Details({params}: {params: {id: string}}) {

  const data = await getDetailedValidData(params.id);

  return (
    <div className='mx-auto max-w-[75%] shadow-lg p-10 bg-white rounded-lg'>
      <Heading title='Обновите ваш аукцион' subtitle='Пожалуйста, обновите данные вашей машины!'/>
      <AuctionForm auction={data}/>
    </div>
  )
}
