class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.23.2"
    checksums = {
        "darwin_arm64" => "5b561c3e0463c7cf465717d6ba0d41f4b99e0d3eafb4ed64958b1d497821e9b9",
        "darwin_amd64" => "4a0be1d5c972b104c8b81aacecf0c07f24f9e69fb582ba1ca50e5be1a5a64f39",
        "linux_arm64"  => "ddeb6d4386e9c4cde0bbe7755b5674908d4fa206c56af3bcda8952c62dd097f8",
        "linux_amd64"  => "c31b0eaf50eda45883c9b34929a44f18c287338dd37fa74d944b3c161cd6b7fc",
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
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
