export type PagedResult<T> = {
    results: T[],
    pageCount: number,
    totalCount: number
}

export type Auction = {
    reservePrice: number
    seller: string
    winner?: string
    soldAmount: any
    currentHighBid: any
    createdAt: string
    updatedAt: string
    auctionEnd: string
    status: string
    model: string
    make: string
    year: number
    color: string
    mileage: number
    imageUrl: string
    id: string
  }