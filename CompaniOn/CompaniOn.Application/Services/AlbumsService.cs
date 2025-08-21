using AutoMapper;
using FluentValidation;
using CompaniOn.Core;
using CompaniOn.Application.Interfaces;
using CompaniOn.Infrastructure;
using CompaniOn.Infrastructure.Interfaces;

namespace CompaniOn.Application
{
    public class AlbumsService : BaseService<Album, AlbumDto, AlbumUpsertDto, AlbumSearchObject, IAlbumsRepository>, IAlbumsService
    {
        private readonly IPhotosRepository _photosRepository;
        public AlbumsService(IMapper mapper, IUnitOfWork unitOfWork, IValidator<AlbumUpsertDto> validator, IPhotosRepository photosRepository) : base(mapper, unitOfWork, validator)
        {
            _photosRepository = photosRepository;
        }

        public override async Task<AlbumDto> AddAsync(AlbumUpsertDto dto, CancellationToken cancellationToken = default)
        {
            await ValidateAsync(dto, cancellationToken);

            var entity = Mapper.Map<Album>(dto);

            if (dto.CoverPhoto != null)
            {
                Photo photo = new Photo() { Data = dto.CoverPhoto , CreatedAt = DateTime.Now };
                await _photosRepository.AddAsync(photo);
                await UnitOfWork.SaveChangesAsync();
                entity.CoverPhotoId = photo.Id;
            }

            await CurrentRepository.AddAsync(entity, cancellationToken);
            await UnitOfWork.SaveChangesAsync(cancellationToken);

            return Mapper.Map<AlbumDto>(entity);
        }

        public override async Task<AlbumDto> UpdateAsync(AlbumUpsertDto dto, CancellationToken cancellationToken = default)
        {
            await ValidateAsync(dto, cancellationToken);

            if (dto.Id == null)
                throw new Exception("Album not found");

            var album = await CurrentRepository.GetByIdAsync(dto.Id.Value, cancellationToken);

            if (album == null)
                throw new Exception("Album item not found");

            var existingCoverPhotoId = album.CoverPhotoId ?? 0;

            Mapper.Map(dto, album);

            if (dto.CoverPhoto == null && existingCoverPhotoId > 0)
            {
                album.CoverPhotoId = existingCoverPhotoId;
            }
            else if (dto.CoverPhoto != null)
            {
                if (existingCoverPhotoId > 0)
                {
                    Photo photo = new Photo() { Id = existingCoverPhotoId, Data = dto.CoverPhoto, ModifiedAt = DateTime.Now };
                    _photosRepository.Update(photo);
                    await UnitOfWork.SaveChangesAsync();
                }
                else
                {
                    Photo photo = new Photo() { Id = 0, Data = dto.CoverPhoto, CreatedAt = DateTime.Now  };
                    await _photosRepository.AddAsync(photo);
                    await UnitOfWork.SaveChangesAsync();
                    album.CoverPhotoId = photo.Id;
                }
            }

            CurrentRepository.Update(album);
            await UnitOfWork.SaveChangesAsync();

            return Mapper.Map<AlbumDto>(album);
        }
}
}
