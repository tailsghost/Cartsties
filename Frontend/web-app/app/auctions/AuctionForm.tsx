"use client";

import { Button, TextInput } from "flowbite-react";
import React, { useEffect } from "react";
import { FieldValues, useForm } from "react-hook-form";
import Input from "../components/Input";
import DateInput from "../components/DateInput";
import { createAuction, updateAuction } from "../actions/auctionActions";
import { usePathname, useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { Auction } from "@/types";

type Props = {
  auction?: Auction;
};

export default function AuctionForm({ auction }: Props) {
  const router = useRouter();
  const pathname = usePathname();
  const {
    control,
    handleSubmit,
    setFocus,
    reset,
    formState: { isSubmitting, isValid, isDirty, errors },
  } = useForm({
    mode: "onTouched",
  });

  useEffect(() => {
    if (auction) {
      const { make, model, color, mileage, year } = auction;
      reset({ make, model, color, mileage, year });
    }
    setFocus("make");
  }, [setFocus]);

  async function onSubmit(data: FieldValues) {
    try {
      let id = "";
      let res;
      if (pathname === "/auctions/create") {
        res = await createAuction(data);
        id = res.id;
      } else {
        if (auction) {
          res = await updateAuction(data, auction.id);
          id = auction.id;
        }
      }

      if (res.error) {
        throw res.error;
      }
      router.push(`/auctions/details/${id}`);
    } catch (error: any) {
      toast.error(error.status + " " + error.message);
    }
  }

  return (
    <form className="flex flex-col mt-3" onSubmit={handleSubmit(onSubmit)}>
      <Input
        label="Марка"
        name="make"
        control={control}
        rules={{ required: "Марка обязательна!" }}
      />
      <Input
        label="Модель"
        name="model"
        control={control}
        rules={{ required: "Модель обязательна!" }}
      />
      <Input
        label="Цвет"
        name="color"
        control={control}
        rules={{ required: "Цвет обязателен!" }}
      />

      <div className="grid grid-cols-2 gap-3">
        <Input
          label="Год выпуска"
          name="year"
          type="number"
          control={control}
          rules={{ required: "Год выпуска обязателен!" }}
        />
        <Input
          label="Пробег"
          name="mileage"
          type="number"
          control={control}
          rules={{ required: "Пробег обязателен!" }}
        />
      </div>

      {pathname === '/auctions/create' &&
      <>
        <Input
          label="Фото (URL)"
          name="imageUrl"
          control={control}
          rules={{ required: "Фото обязательна!" }}
        />

        <div className="grid grid-cols-2 gap-3">
          <Input
            label="Начальная цена (Введите 0, если без начальной)"
            name="reservePrice"
            type="number"
            control={control}
            rules={{ required: "Начальная цена обязательна!" }}
          />
          <DateInput
            label="Дата окончания аукциона"
            name="auctionEnd"
            dateFormat="dd MMMM yyyy h:mm a"
            showTimeSelect
            control={control}
            rules={{ required: "Дата обязательна!" }}
          />
        </div>
      </>}

      <div className="flex justify-between">
        <Button outline color="gray">
          Назад
        </Button>
        <Button
          isProcessing={isSubmitting}
          disabled={!isValid}
          type="submit"
          outline
          color="success"
        >
          Отправить
        </Button>
      </div>
    </form>
  );
}
