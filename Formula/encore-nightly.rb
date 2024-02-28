class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.32.0-nightly.20240228"
    checksums = {
        "darwin_arm64" => "66be01a9d95bc8e87b0f3f29e45bb1b32e3759bd1a45268aaf6c7b9294bf924f",
        "darwin_amd64" => "2963c90a176d1f57f7e180304a92d6758927be435e392c1aeffb3347ff963294",
        "linux_arm64"  => "cdb6c3e9f38bc7fabab334f7e522bed225280d52ca0efc77b7eb2151e849cb55",
        "linux_amd64"  => "025c189a3e97cdb7daf7b1069e6cfb8616c88e3bb699bca0c949f6f5a78a9d55",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink libexec/"bin/encore-nightly"


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "bash")
        (bash_completion/"encore-nightly").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "zsh")
        (zsh_completion/"_encore-nightly").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore-nightly", "completion", "fish")
        (fish_completion/"encore-nightly.fish").write output
    end

    test do
        system "#{bin}/encore-nightly", "check"
    end
end
