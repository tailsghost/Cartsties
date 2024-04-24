"use client"

import { Button, TextInput } from 'flowbite-react';
import React from 'react'
import { FieldValues, useForm } from 'react-hook-form'

export default function AuctionForm() {

    const {register, handleSubmit, setFocus, 
        formState: {isSubmitting, isValid, isDirty, errors}} = useForm();

        function onSubmit(data: FieldValues) {
            console.log(data);
        }

  return (
    <form className='flex flex-col mt-3' onSubmit={handleSubmit(onSubmit)}>
        <div className='mb-3 block'>
            <TextInput 
                {...register("make", {required: "Марка авто обязательна!"})}
                placeholder='Марка авто'
                color={errors?.make && "failure"}
                helperText={errors.make?.message as string}
            />
        </div>
        <div className='mb-3 block'>
        <TextInput 
                {...register("model", {required: "Модель авто обязательна!"})}
                placeholder='Модель авто'
                color={errors?.model && "failure"}
                helperText={errors.model?.message as string}
            />
        </div>
        <div className='flex justify-between'>
        <Button outline color="gray">Назад</Button>
        <Button isProcessing={isSubmitting}
        type='submit'
         outline color="success">Отправить</Button>
        </div>
    </form>
  )
}
