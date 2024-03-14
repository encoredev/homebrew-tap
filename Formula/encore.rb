class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.34.0"
    checksums = {
        "darwin_arm64" => "0ec582e12601a20dabe348d44dd50c1da6631ab4890eb0af452eba29bdbf094c",
        "darwin_amd64" => "bb1981834ad12899bdc0314e985f16996874e284d11efd3776accad373572607",
        "linux_arm64"  => "be3c5f205126e6b9a1d8639dab0da9ab121c89d031878d871068c7eb2e188c33",
        "linux_amd64"  => "a0085ffbc515c8a397c04cabb4aa12a0172eb984ec9a2ffd89576437629fd966",
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
