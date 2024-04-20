"use client";

import AuctionCard from "./AuctionCard";
import AppPagination from "../components/AppPagination";
import { useActionState, useEffect, useState } from "react";
import { Auction, PagedResult } from "@/types";
import { getData } from "../actions/auctionActions";
import { Flowbite } from "flowbite-react";
import { customThemePagination } from "../customStyle/CustomThemePagination";
import Filters from "./Filters";
import { useParamsStore } from "@/hooks/useParamsStore";
import { shallow } from "zustand/shallow";
import qs from "query-string";
import EmptyFilter from "../components/EmptyFilter";

export default function Listings() {
  const [data, setData] = useState<PagedResult<Auction>>();
  const params = useParamsStore(
    (state) => ({
      pageNumber: state.pageNumber,
      pageSize: state.pageSize,
      searchTerm: state.searchTern,
      orderBy: state.orderBy,
      filterBy: state.filterBy,
    }),
    shallow
  );
  const setParams = useParamsStore((state) => state.setParams);
  const url = qs.stringifyUrl({ url: "", query: params });

  function setPageNumber(pageNumber: number) {
    setParams({ pageNumber });
  }

  useEffect(() => {
    getData(url).then((data) => {
      setData(data);
    });
  }, [url]);

  if (!data) return <h3>Loading...</h3>;

  return (
    <>
      <Filters />
      {data.totalCount === 0 ? (
        <EmptyFilter showReser />
      ) : (
        <>
          <div className="grid grid-cols-4 gap-6">
            {data.results.map((auction) => (
              <AuctionCard auction={auction} key={auction.id} />
            ))}
          </div>
          <Flowbite theme={{ theme: customThemePagination }}>
            <AppPagination
              pageChange={setPageNumber}
              currentPage={params.pageNumber}
              pageCount={data.pageCount}
            />
          </Flowbite>
        </>
      )}
    </>
  );
}
