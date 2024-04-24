"use client";

import { useParamsStore } from "@/hooks/useParamsStore";
import React, { useState } from "react";
import { FaSearch } from "react-icons/fa";

export default function Search() {
  const setParams = useParamsStore((state) => state.setParams);
  const setSearchValue = useParamsStore(state => state.setSearchValue);
  const searchValue = useParamsStore(state => state.searchValue);

  function onChange(event: any) {
    setSearchValue(event.target.value)
  }

  function search() {
    setParams({ searchTern: searchValue });
  }

  return (
    <div className="flex w-[50%] items-center border-2 rounded-full py-2 shadow-sm">
      <input
        onKeyDown={(e: any) => {
            if (e.key === "Enter") search();
        }}
        value={searchValue}
        onChange={onChange}
        type="text"
        placeholder="Поиск по марке авто, модели, цвету"
        className="
        flex-grow
        pl-5
        bg-transparent
        focus:outline-none
        border-transparent
        focus:border-transparent
        focus:ring-0
        text-sm
        text-gray-600
        "
      />
      <button onClick={search}>
        <FaSearch
          size={35}
          className="bg-red-400 text-white rounded-full p-2 cursor-pointer mx-2"
        />
      </button>
    </div>
  );
}