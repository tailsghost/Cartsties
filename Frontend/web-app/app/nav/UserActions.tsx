"use client"

import { useParamsStore } from '@/hooks/useParamsStore'
import { Dropdown, DropdownDivider } from 'flowbite-react'

import {User} from "next-auth"
import { signOut } from 'next-auth/react'
import Link from 'next/link'
import { usePathname, useRouter } from 'next/navigation'
import { AiFillCar, AiFillTrophy, AiOutlineLogout } from 'react-icons/ai'
import { HiCog, HiUser } from 'react-icons/hi2'

type Props = {
    user: User
}


export default function UserActions({user}: Props) {

  const router = useRouter();
  const pathname = usePathname();
  const setParams = useParamsStore(state => state.setParams)

  function setWinner() {
    setParams({winner: user.username, seller: undefined})
    if (pathname !== "/") router.push("/");
  }

  function setSeller() {
    setParams({seller: user.username, winner: undefined})
    if (pathname !== "/") router.push("/");
  }

  return (
    <Dropdown label={`Добро пожаловать, ${user.name}`}>
      <Dropdown.Item icon={HiUser} onClick={setSeller}>
            Мой аукцион
      </Dropdown.Item>
      <Dropdown.Item icon={AiFillTrophy} onClick={setWinner}>
            Выигранные аукционы
      </Dropdown.Item>
      <Dropdown.Item icon={AiFillCar}>
        <Link href="/auctions/create">
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
