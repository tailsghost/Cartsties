import { useParamsStore } from "@/hooks/useParamsStore";
import { Button } from "flowbite-react";
import { AiOutlineClockCircle, AiOutlineSortAscending } from "react-icons/ai";
import { BsFillStopCircleFill, BsStopwatchFill } from "react-icons/bs";
import { GiFinishLine, GiFlame } from "react-icons/gi";

const pageSizeButtons = [4, 8, 12];

const orderButtons = [
  {
    label: "По алфавиту",
    icon: AiOutlineSortAscending,
    value: "make",
  },
  {
    label: "По времени",
    icon: AiOutlineClockCircle,
    value: "endingSoon",
  },
  {
    label: "Недавно добавлен",
    icon: BsFillStopCircleFill,
    value: "new",
  },
];

const filterButtons = [
  {
    label: "Действующие",
    icon: GiFlame,
    value: "live",
  },
  {
    label: "Завершится < 6 часов",
    icon: GiFinishLine,
    value: "endingSoon",
  },
  {
    label: "Завершен",
    icon: BsStopwatchFill,
    value: "finished",
  },
];

type Props = {
  pageSize: number;
  setPageSite: (size: number) => void;
};

export default function Filters() {
  const pageSize = useParamsStore((state) => state.pageSize);
  const setParams = useParamsStore((state) => state.setParams);
  const orderBy = useParamsStore((state) => state.orderBy);
  const filterBy = useParamsStore((state) => state.filterBy);

  return (
    <div className="flex justify-between items-center mb-4">
      <div>
        <span className="uppercase text-sm text-gray-500 mr-2 font-medium">
          Поиск по
        </span>
        <Button.Group>
          {filterButtons.map(({ label, icon: Icon, value }) => (
            <Button
              key={value}
              onClick={() => setParams({ filterBy: value })}
              color={`${filterBy === value ? "red" : "gray"}`}
              className="focus:ring-0 items-center h-10 mr-1 rounded-lg p-2"
            >
              <Icon className="mr-3 h-5 w-6 mb-1" />
              {label}
            </Button>
          ))}
        </Button.Group>
      </div>

      <div>
        <span className="uppercase text-sm text-gray-500 mr-2 font-medium bottom-1">
          Поиск по
        </span>
        <Button.Group>
          {orderButtons.map(({ label, icon: Icon, value }) => (
            <Button
              key={value}
              onClick={() => setParams({ orderBy: value })}
              color={`${orderBy === value ? "red" : "gray"}`}
              className="items-center h-10 mr-1 rounded-lg p-2"
            >
              <Icon className="mr-3 h-5 w-6 mb-1" />
              {label}
            </Button>
          ))}
        </Button.Group>
      </div>

      <div>
        <span className="uppercase text-sm text-gray-500 mr-2">
          Кол-во авто
        </span>
        <Button.Group>
          {pageSizeButtons.map((value, i) => (
            <Button
              key={i}
              onClick={() => setParams({ pageSize: value })}
              color={`${pageSize === value ? "red" : "gray"}`}
              className="focus:ring-0 w-7 shadow-lg rounded-lg mr-1"
            >
              {value}
            </Button>
          ))}
        </Button.Group>
      </div>
    </div>
  );
}
