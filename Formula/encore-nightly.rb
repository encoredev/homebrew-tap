class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230927"
    checksums = {
        "darwin_arm64" => "4d03f6769d44bcf5ef3bc507e3c387ff7e54d53604bfd1c6c72dbf7a20ac0240",
        "darwin_amd64" => "26a0fde80d6c74a1aa3f18b2fe93cd2f2cf1f4a1af19fab2b45325370f2b4ed1",
        "linux_arm64"  => "f17fe3719f25e615ae5a71446fa21247e78a183c6a33d4e76c47895e3f3b7ef7",
        "linux_amd64"  => "3b4a2d0008bb75c10817bca6611df998cbbd75492b9a63e3ff1f9d6596a5d88c",
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
