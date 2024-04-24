"use client"

import { Dropdown, DropdownDivider } from 'flowbite-react'

import {User} from "next-auth"
import { signOut } from 'next-auth/react'
import Link from 'next/link'
import { AiFillCar, AiFillTrophy, AiOutlineLogout } from 'react-icons/ai'
import { HiCog, HiUser } from 'react-icons/hi2'

type Props = {
    user: Partial<User>
}


export default function UserActions({user}: Props) {
  return (
    <Dropdown label={`Добро пожаловать, ${user.name}`}>
      <Dropdown.Item icon={HiUser}>
        <Link href="/">
            Мой аукцион
        </Link>
      </Dropdown.Item>
      <Dropdown.Item icon={AiFillTrophy}>
        <Link href="/">
            Выигранные аукционы
        </Link>
      </Dropdown.Item>
      <Dropdown.Item icon={AiFillCar}>
        <Link href="/">
            Выставить на аукцион
        </Link>
      </Dropdown.Item>
      <Dropdown.Item icon={HiCog}>
        <Link href="/session">
            Сессия (Только для разработчиков)
        </Link>
      </Dropdown.Item>
      <Dropdown.Divider />
      <Dropdown.Item icon={AiOutlineLogout} onClick={() => signOut({callbackUrl: "/"})}>
        <Link href="/session">
            Выход
        </Link>
      </Dropdown.Item>
    </Dropdown>
  )
}
