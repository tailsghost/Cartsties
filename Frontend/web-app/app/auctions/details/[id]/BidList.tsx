'use client'

import { getBidsForAuction } from '@/app/actions/auctionActions'
import Heading from '@/app/components/Heading'
import { useBidStore } from '@/hooks/useBidStore'
import { Auction, Bid } from '@/types'
import { User } from 'next-auth'
import React, { useEffect, useState } from 'react'
import { toast } from 'react-hot-toast'
import BidItem from './BidItem'
import { numberWithCommas } from '@/app/lib/numberWithComma'
import EmptyFilter from '@/app/components/EmptyFilter'
import BidForm from './BidForm'

type Props = {
    user: User | null
    auction: Auction
}

export default function BidList({ user, auction }: Props) {
    const [loading, setLoading] = useState(true);
    const bids = useBidStore(state => state.bids);
    const setBids = useBidStore(state => state.setBids);
    const open = useBidStore(state => state.open);
    const setOpen = useBidStore(state => state.setOpen);
    const openForBids = new Date(auction.auctionEnd) > new Date();

    const highBid = bids.reduce((prev, current) => prev > current.amount
        ? prev
        : current.bidStatus.includes('Accepted')
            ? current.amount
            : prev, 0)

    useEffect(() => {
        getBidsForAuction(auction.id)
            .then((res: any) => {
                if (res.error) {
                    throw res.error
                }
                setBids(res as Bid[]);
            }).catch(err => {
                toast.error(err.message);
            }).finally(() => setLoading(false))
    }, [auction.id, setLoading, setBids])

    useEffect(() => {
        setOpen(openForBids);
    }, [openForBids, setOpen]);

    if (loading) return <span>Загрузка ставок...</span>

    return (
        <div className='rounded-lg shadow-md'>
            <div className='py-2 px-4 bg-white'>
                <div className='sticky top-0 bg-white p-2'>
                    <Heading title={`Текущая максимальная ставка $${numberWithCommas(highBid)}`} />
                </div>
            </div>

            <div className='overflow-auto h-[400px] flex flex-col-reverse px-2'>
                {bids.length === 0 ? (
                    <EmptyFilter title='Нет ставок для автомобиля'
                        subtitle='Пожалуйста, сделайте ставку' />
                ) : (
                    <>
                        {bids.map(bid => (
                            <BidItem key={bid.id} bid={bid} />
                        ))}
                    </>
                )}
            </div>

            <div className='px-2 pb-2 text-gray-500'>
                {!open ? (
                    <div className='flex items-center justify-center p-2 text-lg font-semibold'>
                        Аукцион завершен
                    </div>
                ) : !user ? (
                    <div className='flex items-center justify-center p-2 text-lg font-semibold'>
                        Пожалуйста, авторизуйтесь, чтобы сделать ставку
                    </div>
                ) : user && user.username === auction.seller ? (
                    <div className='flex items-center justify-center p-2 text-lg font-semibold'>
                        Вы не можете сделать ставку в своем же аукционе
                    </div>
                ) : (
                    <BidForm auctionId={auction.id} highBid={highBid} />
                )}
            </div>
        </div>
    )
}