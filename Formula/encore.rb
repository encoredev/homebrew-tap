class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.35.0"
    checksums = {
        "darwin_arm64" => "e3b420d88628c42edcc317d1943a6f4c62ef7e240c64386162ef0684acc8b3a0",
        "darwin_amd64" => "2eec915646adb4892791e818b8c937c7abe89cdf3aada17bbd307cbacece6b4f",
        "linux_arm64"  => "2b27fdcc430239c9a86ef0dd30e55cd25fd54d3d044d417ad2de95c5703650e3",
        "linux_amd64"  => "14eca65e5c8523efcf7d3ea4d26edf0c478ffc9f457df0ddb5d17a75fb1b93cd",
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
