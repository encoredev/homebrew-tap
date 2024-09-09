class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.0"
    checksums = {
        "darwin_arm64" => "ca279ea7f5cbafa044e4488138def0590341484c290011dabe239caa2cde3b0a",
        "darwin_amd64" => "a714fdd5e6a07412d6ebd19b76eae89dbdace9ddfadc51eb766ce9b4af3e8a44",
        "linux_arm64"  => "17b38037aae81593a3f444ad11640803b4c404a0a6a87239c668a86e0bf21297",
        "linux_amd64"  => "588d48d79c0cacfbc1603dc86e4dd7e6fdd5d87664d4c45cc427c5cdab18f5f9",
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
